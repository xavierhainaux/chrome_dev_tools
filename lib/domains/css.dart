/// This domain exposes CSS read/write operations. All CSS objects (stylesheets,
/// rules, and styles) have an associated `id` used in subsequent operations on
/// the related object. Each object type has a specific `id` structure, and
/// those are not interchangeable between objects of different kinds. CSS
/// objects can be loaded using the `get*ForNode()` calls (which accept a DOM
/// node id). A client can also keep track of stylesheets via the
/// `styleSheetAdded`/`styleSheetRemoved` events and subsequently load the
/// required stylesheet contents using the `getStyleSheet[Text]()` methods.

import 'dart:async';
import 'package:meta/meta.dart' show required;
import '../src/connection.dart';
import 'dom.dart' as dom;
import 'page.dart' as page;

class CSSManager {
  final Client _client;

  CSSManager(this._client);

  /// Fires whenever a MediaQuery result changes (for example, after a browser
  /// window has been resized.) The current implementation considers only
  /// viewport-dependent media features.
  Stream get onMediaQueryResultChanged => _client.onEvent
      .where((Event event) => event.name == 'CSS.mediaQueryResultChanged');

  /// Fires whenever a web font gets loaded.
  Stream get onFontsUpdated =>
      _client.onEvent.where((Event event) => event.name == 'CSS.fontsUpdated');

  /// Fired whenever a stylesheet is changed as a result of the client
  /// operation.
  Stream<StyleSheetId> get onStyleSheetChanged => _client.onEvent
      .where((Event event) => event.name == 'CSS.styleSheetChanged')
      .map((Event event) =>
          new StyleSheetId.fromJson(event.parameters['styleSheetId']));

  /// Fired whenever an active document stylesheet is added.
  Stream<CSSStyleSheetHeader> get onStyleSheetAdded => _client.onEvent
      .where((Event event) => event.name == 'CSS.styleSheetAdded')
      .map((Event event) =>
          new CSSStyleSheetHeader.fromJson(event.parameters['header']));

  /// Fired whenever an active document stylesheet is removed.
  Stream<StyleSheetId> get onStyleSheetRemoved => _client.onEvent
      .where((Event event) => event.name == 'CSS.styleSheetRemoved')
      .map((Event event) =>
          new StyleSheetId.fromJson(event.parameters['styleSheetId']));

  /// Enables the CSS agent for the given page. Clients should not assume that
  /// the CSS agent has been enabled until the result of this command is
  /// received.
  Future enable() async {
    await _client.send('CSS.enable');
  }

  /// Disables the CSS agent for the given page.
  Future disable() async {
    await _client.send('CSS.disable');
  }

  /// Returns requested styles for a DOM node identified by `nodeId`.
  Future<GetMatchedStylesForNodeResult> getMatchedStylesForNode(
    dom.NodeId nodeId,
  ) async {
    Map parameters = {
      'nodeId': nodeId.toJson(),
    };
    Map result = await _client.send('CSS.getMatchedStylesForNode', parameters);
    return new GetMatchedStylesForNodeResult.fromJson(result);
  }

  /// Returns the styles defined inline (explicitly in the "style" attribute and
  /// implicitly, using DOM attributes) for a DOM node identified by `nodeId`.
  Future<GetInlineStylesForNodeResult> getInlineStylesForNode(
    dom.NodeId nodeId,
  ) async {
    Map parameters = {
      'nodeId': nodeId.toJson(),
    };
    Map result = await _client.send('CSS.getInlineStylesForNode', parameters);
    return new GetInlineStylesForNodeResult.fromJson(result);
  }

  /// Returns the computed style for a DOM node identified by `nodeId`.
  /// Returns: Computed style for the specified DOM node.
  Future<List<CSSComputedStyleProperty>> getComputedStyleForNode(
    dom.NodeId nodeId,
  ) async {
    Map parameters = {
      'nodeId': nodeId.toJson(),
    };
    Map result = await _client.send('CSS.getComputedStyleForNode', parameters);
    return (result['computedStyle'] as List)
        .map((e) => new CSSComputedStyleProperty.fromJson(e))
        .toList();
  }

  /// Requests information about platform fonts which we used to render child
  /// TextNodes in the given node.
  /// Returns: Usage statistics for every employed platform font.
  Future<List<PlatformFontUsage>> getPlatformFontsForNode(
    dom.NodeId nodeId,
  ) async {
    Map parameters = {
      'nodeId': nodeId.toJson(),
    };
    Map result = await _client.send('CSS.getPlatformFontsForNode', parameters);
    return (result['fonts'] as List)
        .map((e) => new PlatformFontUsage.fromJson(e))
        .toList();
  }

  /// Returns the current textual content and the URL for a stylesheet.
  /// Returns: The stylesheet text.
  Future<String> getStyleSheetText(
    StyleSheetId styleSheetId,
  ) async {
    Map parameters = {
      'styleSheetId': styleSheetId.toJson(),
    };
    Map result = await _client.send('CSS.getStyleSheetText', parameters);
    return result['text'];
  }

  /// Returns all class names from specified stylesheet.
  /// Returns: Class name list.
  Future<List<String>> collectClassNames(
    StyleSheetId styleSheetId,
  ) async {
    Map parameters = {
      'styleSheetId': styleSheetId.toJson(),
    };
    Map result = await _client.send('CSS.collectClassNames', parameters);
    return (result['classNames'] as List).map((e) => e as String).toList();
  }

  /// Sets the new stylesheet text.
  /// Returns: URL of source map associated with script (if any).
  Future<String> setStyleSheetText(
    StyleSheetId styleSheetId,
    String text,
  ) async {
    Map parameters = {
      'styleSheetId': styleSheetId.toJson(),
      'text': text,
    };
    Map result = await _client.send('CSS.setStyleSheetText', parameters);
    return result['sourceMapURL'];
  }

  /// Modifies the rule selector.
  /// Returns: The resulting selector list after modification.
  Future<SelectorList> setRuleSelector(
    StyleSheetId styleSheetId,
    SourceRange range,
    String selector,
  ) async {
    Map parameters = {
      'styleSheetId': styleSheetId.toJson(),
      'range': range.toJson(),
      'selector': selector,
    };
    Map result = await _client.send('CSS.setRuleSelector', parameters);
    return new SelectorList.fromJson(result['selectorList']);
  }

  /// Modifies the keyframe rule key text.
  /// Returns: The resulting key text after modification.
  Future<Value> setKeyframeKey(
    StyleSheetId styleSheetId,
    SourceRange range,
    String keyText,
  ) async {
    Map parameters = {
      'styleSheetId': styleSheetId.toJson(),
      'range': range.toJson(),
      'keyText': keyText,
    };
    Map result = await _client.send('CSS.setKeyframeKey', parameters);
    return new Value.fromJson(result['keyText']);
  }

  /// Applies specified style edits one after another in the given order.
  /// Returns: The resulting styles after modification.
  Future<List<CSSStyle>> setStyleTexts(
    List<StyleDeclarationEdit> edits,
  ) async {
    Map parameters = {
      'edits': edits.map((e) => e.toJson()).toList(),
    };
    Map result = await _client.send('CSS.setStyleTexts', parameters);
    return (result['styles'] as List)
        .map((e) => new CSSStyle.fromJson(e))
        .toList();
  }

  /// Modifies the rule selector.
  /// Returns: The resulting CSS media rule after modification.
  Future<CSSMedia> setMediaText(
    StyleSheetId styleSheetId,
    SourceRange range,
    String text,
  ) async {
    Map parameters = {
      'styleSheetId': styleSheetId.toJson(),
      'range': range.toJson(),
      'text': text,
    };
    Map result = await _client.send('CSS.setMediaText', parameters);
    return new CSSMedia.fromJson(result['media']);
  }

  /// Creates a new special "via-inspector" stylesheet in the frame with given
  /// `frameId`.
  /// [frameId] Identifier of the frame where "via-inspector" stylesheet should
  /// be created.
  /// Returns: Identifier of the created "via-inspector" stylesheet.
  Future<StyleSheetId> createStyleSheet(
    page.FrameId frameId,
  ) async {
    Map parameters = {
      'frameId': frameId.toJson(),
    };
    Map result = await _client.send('CSS.createStyleSheet', parameters);
    return new StyleSheetId.fromJson(result['styleSheetId']);
  }

  /// Inserts a new rule with the given `ruleText` in a stylesheet with given
  /// `styleSheetId`, at the position specified by `location`.
  /// [styleSheetId] The css style sheet identifier where a new rule should be
  /// inserted.
  /// [ruleText] The text of a new rule.
  /// [location] Text position of a new rule in the target style sheet.
  /// Returns: The newly created rule.
  Future<CSSRule> addRule(
    StyleSheetId styleSheetId,
    String ruleText,
    SourceRange location,
  ) async {
    Map parameters = {
      'styleSheetId': styleSheetId.toJson(),
      'ruleText': ruleText,
      'location': location.toJson(),
    };
    Map result = await _client.send('CSS.addRule', parameters);
    return new CSSRule.fromJson(result['rule']);
  }

  /// Ensures that the given node will have specified pseudo-classes whenever
  /// its style is computed by the browser.
  /// [nodeId] The element id for which to force the pseudo state.
  /// [forcedPseudoClasses] Element pseudo classes to force when computing the
  /// element's style.
  Future forcePseudoState(
    dom.NodeId nodeId,
    List<String> forcedPseudoClasses,
  ) async {
    Map parameters = {
      'nodeId': nodeId.toJson(),
      'forcedPseudoClasses': forcedPseudoClasses.map((e) => e).toList(),
    };
    await _client.send('CSS.forcePseudoState', parameters);
  }

  /// Returns all media queries parsed by the rendering engine.
  Future<List<CSSMedia>> getMediaQueries() async {
    Map result = await _client.send('CSS.getMediaQueries');
    return (result['medias'] as List)
        .map((e) => new CSSMedia.fromJson(e))
        .toList();
  }

  /// Find a rule with the given active property for the given node and set the
  /// new value for this property
  /// [nodeId] The element id for which to set property.
  Future setEffectivePropertyValueForNode(
    dom.NodeId nodeId,
    String propertyName,
    String value,
  ) async {
    Map parameters = {
      'nodeId': nodeId.toJson(),
      'propertyName': propertyName,
      'value': value,
    };
    await _client.send('CSS.setEffectivePropertyValueForNode', parameters);
  }

  /// [nodeId] Id of the node to get background colors for.
  Future<GetBackgroundColorsResult> getBackgroundColors(
    dom.NodeId nodeId,
  ) async {
    Map parameters = {
      'nodeId': nodeId.toJson(),
    };
    Map result = await _client.send('CSS.getBackgroundColors', parameters);
    return new GetBackgroundColorsResult.fromJson(result);
  }

  /// Enables the selector recording.
  Future startRuleUsageTracking() async {
    await _client.send('CSS.startRuleUsageTracking');
  }

  /// Obtain list of rules that became used since last call to this method (or
  /// since start of coverage instrumentation)
  Future<List<RuleUsage>> takeCoverageDelta() async {
    Map result = await _client.send('CSS.takeCoverageDelta');
    return (result['coverage'] as List)
        .map((e) => new RuleUsage.fromJson(e))
        .toList();
  }

  /// The list of rules with an indication of whether these were used
  Future<List<RuleUsage>> stopRuleUsageTracking() async {
    Map result = await _client.send('CSS.stopRuleUsageTracking');
    return (result['ruleUsage'] as List)
        .map((e) => new RuleUsage.fromJson(e))
        .toList();
  }
}

class GetMatchedStylesForNodeResult {
  /// Inline style for the specified DOM node.
  final CSSStyle inlineStyle;

  /// Attribute-defined element style (e.g. resulting from "width=20
  /// height=100%").
  final CSSStyle attributesStyle;

  /// CSS rules matching this node, from all applicable stylesheets.
  final List<RuleMatch> matchedCSSRules;

  /// Pseudo style matches for this node.
  final List<PseudoElementMatches> pseudoElements;

  /// A chain of inherited styles (from the immediate node parent up to the DOM
  /// tree root).
  final List<InheritedStyleEntry> inherited;

  /// A list of CSS keyframed animations matching this node.
  final List<CSSKeyframesRule> cssKeyframesRules;

  GetMatchedStylesForNodeResult({
    this.inlineStyle,
    this.attributesStyle,
    this.matchedCSSRules,
    this.pseudoElements,
    this.inherited,
    this.cssKeyframesRules,
  });

  factory GetMatchedStylesForNodeResult.fromJson(Map json) {
    return new GetMatchedStylesForNodeResult(
      inlineStyle: json.containsKey('inlineStyle')
          ? new CSSStyle.fromJson(json['inlineStyle'])
          : null,
      attributesStyle: json.containsKey('attributesStyle')
          ? new CSSStyle.fromJson(json['attributesStyle'])
          : null,
      matchedCSSRules: json.containsKey('matchedCSSRules')
          ? (json['matchedCSSRules'] as List)
              .map((e) => new RuleMatch.fromJson(e))
              .toList()
          : null,
      pseudoElements: json.containsKey('pseudoElements')
          ? (json['pseudoElements'] as List)
              .map((e) => new PseudoElementMatches.fromJson(e))
              .toList()
          : null,
      inherited: json.containsKey('inherited')
          ? (json['inherited'] as List)
              .map((e) => new InheritedStyleEntry.fromJson(e))
              .toList()
          : null,
      cssKeyframesRules: json.containsKey('cssKeyframesRules')
          ? (json['cssKeyframesRules'] as List)
              .map((e) => new CSSKeyframesRule.fromJson(e))
              .toList()
          : null,
    );
  }
}

class GetInlineStylesForNodeResult {
  /// Inline style for the specified DOM node.
  final CSSStyle inlineStyle;

  /// Attribute-defined element style (e.g. resulting from "width=20
  /// height=100%").
  final CSSStyle attributesStyle;

  GetInlineStylesForNodeResult({
    this.inlineStyle,
    this.attributesStyle,
  });

  factory GetInlineStylesForNodeResult.fromJson(Map json) {
    return new GetInlineStylesForNodeResult(
      inlineStyle: json.containsKey('inlineStyle')
          ? new CSSStyle.fromJson(json['inlineStyle'])
          : null,
      attributesStyle: json.containsKey('attributesStyle')
          ? new CSSStyle.fromJson(json['attributesStyle'])
          : null,
    );
  }
}

class GetBackgroundColorsResult {
  /// The range of background colors behind this element, if it contains any
  /// visible text. If no visible text is present, this will be undefined. In
  /// the case of a flat background color, this will consist of simply that
  /// color. In the case of a gradient, this will consist of each of the color
  /// stops. For anything more complicated, this will be an empty array. Images
  /// will be ignored (as if the image had failed to load).
  final List<String> backgroundColors;

  /// The computed font size for this node, as a CSS computed value string (e.g.
  /// '12px').
  final String computedFontSize;

  /// The computed font weight for this node, as a CSS computed value string
  /// (e.g. 'normal' or '100').
  final String computedFontWeight;

  /// The computed font size for the document body, as a computed CSS value
  /// string (e.g. '16px').
  final String computedBodyFontSize;

  GetBackgroundColorsResult({
    this.backgroundColors,
    this.computedFontSize,
    this.computedFontWeight,
    this.computedBodyFontSize,
  });

  factory GetBackgroundColorsResult.fromJson(Map json) {
    return new GetBackgroundColorsResult(
      backgroundColors: json.containsKey('backgroundColors')
          ? (json['backgroundColors'] as List).map((e) => e as String).toList()
          : null,
      computedFontSize: json.containsKey('computedFontSize')
          ? json['computedFontSize']
          : null,
      computedFontWeight: json.containsKey('computedFontWeight')
          ? json['computedFontWeight']
          : null,
      computedBodyFontSize: json.containsKey('computedBodyFontSize')
          ? json['computedBodyFontSize']
          : null,
    );
  }
}

class StyleSheetId {
  final String value;

  StyleSheetId(this.value);

  factory StyleSheetId.fromJson(String value) => new StyleSheetId(value);

  String toJson() => value;

  @override
  bool operator ==(other) => other is StyleSheetId && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();
}

/// Stylesheet type: "injected" for stylesheets injected via extension,
/// "user-agent" for user-agent stylesheets, "inspector" for stylesheets created
/// by the inspector (i.e. those holding the "via inspector" rules), "regular"
/// for regular stylesheets.
class StyleSheetOrigin {
  static const StyleSheetOrigin injected = const StyleSheetOrigin._('injected');
  static const StyleSheetOrigin userAgent =
      const StyleSheetOrigin._('user-agent');
  static const StyleSheetOrigin inspector =
      const StyleSheetOrigin._('inspector');
  static const StyleSheetOrigin regular = const StyleSheetOrigin._('regular');
  static const values = const {
    'injected': injected,
    'user-agent': userAgent,
    'inspector': inspector,
    'regular': regular,
  };

  final String value;

  const StyleSheetOrigin._(this.value);

  factory StyleSheetOrigin.fromJson(String value) => values[value];

  String toJson() => value;

  @override
  String toString() => value.toString();
}

/// CSS rule collection for a single pseudo style.
class PseudoElementMatches {
  /// Pseudo element type.
  final dom.PseudoType pseudoType;

  /// Matches of CSS rules applicable to the pseudo style.
  final List<RuleMatch> matches;

  PseudoElementMatches({
    @required this.pseudoType,
    @required this.matches,
  });

  factory PseudoElementMatches.fromJson(Map json) {
    return new PseudoElementMatches(
      pseudoType: new dom.PseudoType.fromJson(json['pseudoType']),
      matches: (json['matches'] as List)
          .map((e) => new RuleMatch.fromJson(e))
          .toList(),
    );
  }

  Map toJson() {
    Map json = {
      'pseudoType': pseudoType.toJson(),
      'matches': matches.map((e) => e.toJson()).toList(),
    };
    return json;
  }
}

/// Inherited CSS rule collection from ancestor node.
class InheritedStyleEntry {
  /// The ancestor node's inline style, if any, in the style inheritance chain.
  final CSSStyle inlineStyle;

  /// Matches of CSS rules matching the ancestor node in the style inheritance
  /// chain.
  final List<RuleMatch> matchedCSSRules;

  InheritedStyleEntry({
    this.inlineStyle,
    @required this.matchedCSSRules,
  });

  factory InheritedStyleEntry.fromJson(Map json) {
    return new InheritedStyleEntry(
      inlineStyle: json.containsKey('inlineStyle')
          ? new CSSStyle.fromJson(json['inlineStyle'])
          : null,
      matchedCSSRules: (json['matchedCSSRules'] as List)
          .map((e) => new RuleMatch.fromJson(e))
          .toList(),
    );
  }

  Map toJson() {
    Map json = {
      'matchedCSSRules': matchedCSSRules.map((e) => e.toJson()).toList(),
    };
    if (inlineStyle != null) {
      json['inlineStyle'] = inlineStyle.toJson();
    }
    return json;
  }
}

/// Match data for a CSS rule.
class RuleMatch {
  /// CSS rule in the match.
  final CSSRule rule;

  /// Matching selector indices in the rule's selectorList selectors (0-based).
  final List<int> matchingSelectors;

  RuleMatch({
    @required this.rule,
    @required this.matchingSelectors,
  });

  factory RuleMatch.fromJson(Map json) {
    return new RuleMatch(
      rule: new CSSRule.fromJson(json['rule']),
      matchingSelectors:
          (json['matchingSelectors'] as List).map((e) => e as int).toList(),
    );
  }

  Map toJson() {
    Map json = {
      'rule': rule.toJson(),
      'matchingSelectors': matchingSelectors.map((e) => e).toList(),
    };
    return json;
  }
}

/// Data for a simple selector (these are delimited by commas in a selector
/// list).
class Value {
  /// Value text.
  final String text;

  /// Value range in the underlying resource (if available).
  final SourceRange range;

  Value({
    @required this.text,
    this.range,
  });

  factory Value.fromJson(Map json) {
    return new Value(
      text: json['text'],
      range: json.containsKey('range')
          ? new SourceRange.fromJson(json['range'])
          : null,
    );
  }

  Map toJson() {
    Map json = {
      'text': text,
    };
    if (range != null) {
      json['range'] = range.toJson();
    }
    return json;
  }
}

/// Selector list data.
class SelectorList {
  /// Selectors in the list.
  final List<Value> selectors;

  /// Rule selector text.
  final String text;

  SelectorList({
    @required this.selectors,
    @required this.text,
  });

  factory SelectorList.fromJson(Map json) {
    return new SelectorList(
      selectors: (json['selectors'] as List)
          .map((e) => new Value.fromJson(e))
          .toList(),
      text: json['text'],
    );
  }

  Map toJson() {
    Map json = {
      'selectors': selectors.map((e) => e.toJson()).toList(),
      'text': text,
    };
    return json;
  }
}

/// CSS stylesheet metainformation.
class CSSStyleSheetHeader {
  /// The stylesheet identifier.
  final StyleSheetId styleSheetId;

  /// Owner frame identifier.
  final page.FrameId frameId;

  /// Stylesheet resource URL.
  final String sourceURL;

  /// URL of source map associated with the stylesheet (if any).
  final String sourceMapURL;

  /// Stylesheet origin.
  final StyleSheetOrigin origin;

  /// Stylesheet title.
  final String title;

  /// The backend id for the owner node of the stylesheet.
  final dom.BackendNodeId ownerNode;

  /// Denotes whether the stylesheet is disabled.
  final bool disabled;

  /// Whether the sourceURL field value comes from the sourceURL comment.
  final bool hasSourceURL;

  /// Whether this stylesheet is created for STYLE tag by parser. This flag is
  /// not set for document.written STYLE tags.
  final bool isInline;

  /// Line offset of the stylesheet within the resource (zero based).
  final num startLine;

  /// Column offset of the stylesheet within the resource (zero based).
  final num startColumn;

  /// Size of the content (in characters).
  final num length;

  CSSStyleSheetHeader({
    @required this.styleSheetId,
    @required this.frameId,
    @required this.sourceURL,
    this.sourceMapURL,
    @required this.origin,
    @required this.title,
    this.ownerNode,
    @required this.disabled,
    this.hasSourceURL,
    @required this.isInline,
    @required this.startLine,
    @required this.startColumn,
    @required this.length,
  });

  factory CSSStyleSheetHeader.fromJson(Map json) {
    return new CSSStyleSheetHeader(
      styleSheetId: new StyleSheetId.fromJson(json['styleSheetId']),
      frameId: new page.FrameId.fromJson(json['frameId']),
      sourceURL: json['sourceURL'],
      sourceMapURL:
          json.containsKey('sourceMapURL') ? json['sourceMapURL'] : null,
      origin: new StyleSheetOrigin.fromJson(json['origin']),
      title: json['title'],
      ownerNode: json.containsKey('ownerNode')
          ? new dom.BackendNodeId.fromJson(json['ownerNode'])
          : null,
      disabled: json['disabled'],
      hasSourceURL:
          json.containsKey('hasSourceURL') ? json['hasSourceURL'] : null,
      isInline: json['isInline'],
      startLine: json['startLine'],
      startColumn: json['startColumn'],
      length: json['length'],
    );
  }

  Map toJson() {
    Map json = {
      'styleSheetId': styleSheetId.toJson(),
      'frameId': frameId.toJson(),
      'sourceURL': sourceURL,
      'origin': origin.toJson(),
      'title': title,
      'disabled': disabled,
      'isInline': isInline,
      'startLine': startLine,
      'startColumn': startColumn,
      'length': length,
    };
    if (sourceMapURL != null) {
      json['sourceMapURL'] = sourceMapURL;
    }
    if (ownerNode != null) {
      json['ownerNode'] = ownerNode.toJson();
    }
    if (hasSourceURL != null) {
      json['hasSourceURL'] = hasSourceURL;
    }
    return json;
  }
}

/// CSS rule representation.
class CSSRule {
  /// The css style sheet identifier (absent for user agent stylesheet and
  /// user-specified stylesheet rules) this rule came from.
  final StyleSheetId styleSheetId;

  /// Rule selector data.
  final SelectorList selectorList;

  /// Parent stylesheet's origin.
  final StyleSheetOrigin origin;

  /// Associated style declaration.
  final CSSStyle style;

  /// Media list array (for rules involving media queries). The array enumerates
  /// media queries starting with the innermost one, going outwards.
  final List<CSSMedia> media;

  CSSRule({
    this.styleSheetId,
    @required this.selectorList,
    @required this.origin,
    @required this.style,
    this.media,
  });

  factory CSSRule.fromJson(Map json) {
    return new CSSRule(
      styleSheetId: json.containsKey('styleSheetId')
          ? new StyleSheetId.fromJson(json['styleSheetId'])
          : null,
      selectorList: new SelectorList.fromJson(json['selectorList']),
      origin: new StyleSheetOrigin.fromJson(json['origin']),
      style: new CSSStyle.fromJson(json['style']),
      media: json.containsKey('media')
          ? (json['media'] as List)
              .map((e) => new CSSMedia.fromJson(e))
              .toList()
          : null,
    );
  }

  Map toJson() {
    Map json = {
      'selectorList': selectorList.toJson(),
      'origin': origin.toJson(),
      'style': style.toJson(),
    };
    if (styleSheetId != null) {
      json['styleSheetId'] = styleSheetId.toJson();
    }
    if (media != null) {
      json['media'] = media.map((e) => e.toJson()).toList();
    }
    return json;
  }
}

/// CSS coverage information.
class RuleUsage {
  /// The css style sheet identifier (absent for user agent stylesheet and
  /// user-specified stylesheet rules) this rule came from.
  final StyleSheetId styleSheetId;

  /// Offset of the start of the rule (including selector) from the beginning of
  /// the stylesheet.
  final num startOffset;

  /// Offset of the end of the rule body from the beginning of the stylesheet.
  final num endOffset;

  /// Indicates whether the rule was actually used by some element in the page.
  final bool used;

  RuleUsage({
    @required this.styleSheetId,
    @required this.startOffset,
    @required this.endOffset,
    @required this.used,
  });

  factory RuleUsage.fromJson(Map json) {
    return new RuleUsage(
      styleSheetId: new StyleSheetId.fromJson(json['styleSheetId']),
      startOffset: json['startOffset'],
      endOffset: json['endOffset'],
      used: json['used'],
    );
  }

  Map toJson() {
    Map json = {
      'styleSheetId': styleSheetId.toJson(),
      'startOffset': startOffset,
      'endOffset': endOffset,
      'used': used,
    };
    return json;
  }
}

/// Text range within a resource. All numbers are zero-based.
class SourceRange {
  /// Start line of range.
  final int startLine;

  /// Start column of range (inclusive).
  final int startColumn;

  /// End line of range
  final int endLine;

  /// End column of range (exclusive).
  final int endColumn;

  SourceRange({
    @required this.startLine,
    @required this.startColumn,
    @required this.endLine,
    @required this.endColumn,
  });

  factory SourceRange.fromJson(Map json) {
    return new SourceRange(
      startLine: json['startLine'],
      startColumn: json['startColumn'],
      endLine: json['endLine'],
      endColumn: json['endColumn'],
    );
  }

  Map toJson() {
    Map json = {
      'startLine': startLine,
      'startColumn': startColumn,
      'endLine': endLine,
      'endColumn': endColumn,
    };
    return json;
  }
}

class ShorthandEntry {
  /// Shorthand name.
  final String name;

  /// Shorthand value.
  final String value;

  /// Whether the property has "!important" annotation (implies `false` if
  /// absent).
  final bool important;

  ShorthandEntry({
    @required this.name,
    @required this.value,
    this.important,
  });

  factory ShorthandEntry.fromJson(Map json) {
    return new ShorthandEntry(
      name: json['name'],
      value: json['value'],
      important: json.containsKey('important') ? json['important'] : null,
    );
  }

  Map toJson() {
    Map json = {
      'name': name,
      'value': value,
    };
    if (important != null) {
      json['important'] = important;
    }
    return json;
  }
}

class CSSComputedStyleProperty {
  /// Computed style property name.
  final String name;

  /// Computed style property value.
  final String value;

  CSSComputedStyleProperty({
    @required this.name,
    @required this.value,
  });

  factory CSSComputedStyleProperty.fromJson(Map json) {
    return new CSSComputedStyleProperty(
      name: json['name'],
      value: json['value'],
    );
  }

  Map toJson() {
    Map json = {
      'name': name,
      'value': value,
    };
    return json;
  }
}

/// CSS style representation.
class CSSStyle {
  /// The css style sheet identifier (absent for user agent stylesheet and
  /// user-specified stylesheet rules) this rule came from.
  final StyleSheetId styleSheetId;

  /// CSS properties in the style.
  final List<CSSProperty> cssProperties;

  /// Computed values for all shorthands found in the style.
  final List<ShorthandEntry> shorthandEntries;

  /// Style declaration text (if available).
  final String cssText;

  /// Style declaration range in the enclosing stylesheet (if available).
  final SourceRange range;

  CSSStyle({
    this.styleSheetId,
    @required this.cssProperties,
    @required this.shorthandEntries,
    this.cssText,
    this.range,
  });

  factory CSSStyle.fromJson(Map json) {
    return new CSSStyle(
      styleSheetId: json.containsKey('styleSheetId')
          ? new StyleSheetId.fromJson(json['styleSheetId'])
          : null,
      cssProperties: (json['cssProperties'] as List)
          .map((e) => new CSSProperty.fromJson(e))
          .toList(),
      shorthandEntries: (json['shorthandEntries'] as List)
          .map((e) => new ShorthandEntry.fromJson(e))
          .toList(),
      cssText: json.containsKey('cssText') ? json['cssText'] : null,
      range: json.containsKey('range')
          ? new SourceRange.fromJson(json['range'])
          : null,
    );
  }

  Map toJson() {
    Map json = {
      'cssProperties': cssProperties.map((e) => e.toJson()).toList(),
      'shorthandEntries': shorthandEntries.map((e) => e.toJson()).toList(),
    };
    if (styleSheetId != null) {
      json['styleSheetId'] = styleSheetId.toJson();
    }
    if (cssText != null) {
      json['cssText'] = cssText;
    }
    if (range != null) {
      json['range'] = range.toJson();
    }
    return json;
  }
}

/// CSS property declaration data.
class CSSProperty {
  /// The property name.
  final String name;

  /// The property value.
  final String value;

  /// Whether the property has "!important" annotation (implies `false` if
  /// absent).
  final bool important;

  /// Whether the property is implicit (implies `false` if absent).
  final bool implicit;

  /// The full property text as specified in the style.
  final String text;

  /// Whether the property is understood by the browser (implies `true` if
  /// absent).
  final bool parsedOk;

  /// Whether the property is disabled by the user (present for source-based
  /// properties only).
  final bool disabled;

  /// The entire property range in the enclosing style declaration (if
  /// available).
  final SourceRange range;

  CSSProperty({
    @required this.name,
    @required this.value,
    this.important,
    this.implicit,
    this.text,
    this.parsedOk,
    this.disabled,
    this.range,
  });

  factory CSSProperty.fromJson(Map json) {
    return new CSSProperty(
      name: json['name'],
      value: json['value'],
      important: json.containsKey('important') ? json['important'] : null,
      implicit: json.containsKey('implicit') ? json['implicit'] : null,
      text: json.containsKey('text') ? json['text'] : null,
      parsedOk: json.containsKey('parsedOk') ? json['parsedOk'] : null,
      disabled: json.containsKey('disabled') ? json['disabled'] : null,
      range: json.containsKey('range')
          ? new SourceRange.fromJson(json['range'])
          : null,
    );
  }

  Map toJson() {
    Map json = {
      'name': name,
      'value': value,
    };
    if (important != null) {
      json['important'] = important;
    }
    if (implicit != null) {
      json['implicit'] = implicit;
    }
    if (text != null) {
      json['text'] = text;
    }
    if (parsedOk != null) {
      json['parsedOk'] = parsedOk;
    }
    if (disabled != null) {
      json['disabled'] = disabled;
    }
    if (range != null) {
      json['range'] = range.toJson();
    }
    return json;
  }
}

/// CSS media rule descriptor.
class CSSMedia {
  /// Media query text.
  final String text;

  /// Source of the media query: "mediaRule" if specified by a @media rule,
  /// "importRule" if specified by an @import rule, "linkedSheet" if specified
  /// by a "media" attribute in a linked stylesheet's LINK tag, "inlineSheet" if
  /// specified by a "media" attribute in an inline stylesheet's STYLE tag.
  final String source;

  /// URL of the document containing the media query description.
  final String sourceURL;

  /// The associated rule (@media or @import) header range in the enclosing
  /// stylesheet (if available).
  final SourceRange range;

  /// Identifier of the stylesheet containing this object (if exists).
  final StyleSheetId styleSheetId;

  /// Array of media queries.
  final List<MediaQuery> mediaList;

  CSSMedia({
    @required this.text,
    @required this.source,
    this.sourceURL,
    this.range,
    this.styleSheetId,
    this.mediaList,
  });

  factory CSSMedia.fromJson(Map json) {
    return new CSSMedia(
      text: json['text'],
      source: json['source'],
      sourceURL: json.containsKey('sourceURL') ? json['sourceURL'] : null,
      range: json.containsKey('range')
          ? new SourceRange.fromJson(json['range'])
          : null,
      styleSheetId: json.containsKey('styleSheetId')
          ? new StyleSheetId.fromJson(json['styleSheetId'])
          : null,
      mediaList: json.containsKey('mediaList')
          ? (json['mediaList'] as List)
              .map((e) => new MediaQuery.fromJson(e))
              .toList()
          : null,
    );
  }

  Map toJson() {
    Map json = {
      'text': text,
      'source': source,
    };
    if (sourceURL != null) {
      json['sourceURL'] = sourceURL;
    }
    if (range != null) {
      json['range'] = range.toJson();
    }
    if (styleSheetId != null) {
      json['styleSheetId'] = styleSheetId.toJson();
    }
    if (mediaList != null) {
      json['mediaList'] = mediaList.map((e) => e.toJson()).toList();
    }
    return json;
  }
}

/// Media query descriptor.
class MediaQuery {
  /// Array of media query expressions.
  final List<MediaQueryExpression> expressions;

  /// Whether the media query condition is satisfied.
  final bool active;

  MediaQuery({
    @required this.expressions,
    @required this.active,
  });

  factory MediaQuery.fromJson(Map json) {
    return new MediaQuery(
      expressions: (json['expressions'] as List)
          .map((e) => new MediaQueryExpression.fromJson(e))
          .toList(),
      active: json['active'],
    );
  }

  Map toJson() {
    Map json = {
      'expressions': expressions.map((e) => e.toJson()).toList(),
      'active': active,
    };
    return json;
  }
}

/// Media query expression descriptor.
class MediaQueryExpression {
  /// Media query expression value.
  final num value;

  /// Media query expression units.
  final String unit;

  /// Media query expression feature.
  final String feature;

  /// The associated range of the value text in the enclosing stylesheet (if
  /// available).
  final SourceRange valueRange;

  /// Computed length of media query expression (if applicable).
  final num computedLength;

  MediaQueryExpression({
    @required this.value,
    @required this.unit,
    @required this.feature,
    this.valueRange,
    this.computedLength,
  });

  factory MediaQueryExpression.fromJson(Map json) {
    return new MediaQueryExpression(
      value: json['value'],
      unit: json['unit'],
      feature: json['feature'],
      valueRange: json.containsKey('valueRange')
          ? new SourceRange.fromJson(json['valueRange'])
          : null,
      computedLength:
          json.containsKey('computedLength') ? json['computedLength'] : null,
    );
  }

  Map toJson() {
    Map json = {
      'value': value,
      'unit': unit,
      'feature': feature,
    };
    if (valueRange != null) {
      json['valueRange'] = valueRange.toJson();
    }
    if (computedLength != null) {
      json['computedLength'] = computedLength;
    }
    return json;
  }
}

/// Information about amount of glyphs that were rendered with given font.
class PlatformFontUsage {
  /// Font's family name reported by platform.
  final String familyName;

  /// Indicates if the font was downloaded or resolved locally.
  final bool isCustomFont;

  /// Amount of glyphs that were rendered with this font.
  final num glyphCount;

  PlatformFontUsage({
    @required this.familyName,
    @required this.isCustomFont,
    @required this.glyphCount,
  });

  factory PlatformFontUsage.fromJson(Map json) {
    return new PlatformFontUsage(
      familyName: json['familyName'],
      isCustomFont: json['isCustomFont'],
      glyphCount: json['glyphCount'],
    );
  }

  Map toJson() {
    Map json = {
      'familyName': familyName,
      'isCustomFont': isCustomFont,
      'glyphCount': glyphCount,
    };
    return json;
  }
}

/// CSS keyframes rule representation.
class CSSKeyframesRule {
  /// Animation name.
  final Value animationName;

  /// List of keyframes.
  final List<CSSKeyframeRule> keyframes;

  CSSKeyframesRule({
    @required this.animationName,
    @required this.keyframes,
  });

  factory CSSKeyframesRule.fromJson(Map json) {
    return new CSSKeyframesRule(
      animationName: new Value.fromJson(json['animationName']),
      keyframes: (json['keyframes'] as List)
          .map((e) => new CSSKeyframeRule.fromJson(e))
          .toList(),
    );
  }

  Map toJson() {
    Map json = {
      'animationName': animationName.toJson(),
      'keyframes': keyframes.map((e) => e.toJson()).toList(),
    };
    return json;
  }
}

/// CSS keyframe rule representation.
class CSSKeyframeRule {
  /// The css style sheet identifier (absent for user agent stylesheet and
  /// user-specified stylesheet rules) this rule came from.
  final StyleSheetId styleSheetId;

  /// Parent stylesheet's origin.
  final StyleSheetOrigin origin;

  /// Associated key text.
  final Value keyText;

  /// Associated style declaration.
  final CSSStyle style;

  CSSKeyframeRule({
    this.styleSheetId,
    @required this.origin,
    @required this.keyText,
    @required this.style,
  });

  factory CSSKeyframeRule.fromJson(Map json) {
    return new CSSKeyframeRule(
      styleSheetId: json.containsKey('styleSheetId')
          ? new StyleSheetId.fromJson(json['styleSheetId'])
          : null,
      origin: new StyleSheetOrigin.fromJson(json['origin']),
      keyText: new Value.fromJson(json['keyText']),
      style: new CSSStyle.fromJson(json['style']),
    );
  }

  Map toJson() {
    Map json = {
      'origin': origin.toJson(),
      'keyText': keyText.toJson(),
      'style': style.toJson(),
    };
    if (styleSheetId != null) {
      json['styleSheetId'] = styleSheetId.toJson();
    }
    return json;
  }
}

/// A descriptor of operation to mutate style declaration text.
class StyleDeclarationEdit {
  /// The css style sheet identifier.
  final StyleSheetId styleSheetId;

  /// The range of the style text in the enclosing stylesheet.
  final SourceRange range;

  /// New style text.
  final String text;

  StyleDeclarationEdit({
    @required this.styleSheetId,
    @required this.range,
    @required this.text,
  });

  factory StyleDeclarationEdit.fromJson(Map json) {
    return new StyleDeclarationEdit(
      styleSheetId: new StyleSheetId.fromJson(json['styleSheetId']),
      range: new SourceRange.fromJson(json['range']),
      text: json['text'],
    );
  }

  Map toJson() {
    Map json = {
      'styleSheetId': styleSheetId.toJson(),
      'range': range.toJson(),
      'text': text,
    };
    return json;
  }
}
