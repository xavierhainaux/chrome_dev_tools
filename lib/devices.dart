import 'src/page/emulation_manager.dart' show Device, DeviceViewport;

const iPhone4 = Device('iPhone 4',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D257 Safari/9537.53',
    viewport: DeviceViewport(
        width: 320,
        height: 480,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final iPhone4Landscape = Device('iPhone 4',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D257 Safari/9537.53',
    viewport: DeviceViewport(
        width: 480,
        height: 320,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const iPhone5SE = Device('iPhone 5/SE',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1',
    viewport: DeviceViewport(
        width: 320,
        height: 568,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final iPhone5SELandscape = Device('iPhone 5/SE',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1',
    viewport: DeviceViewport(
        width: 568,
        height: 320,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const iPhone678 = Device('iPhone 6/7/8',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    viewport: DeviceViewport(
        width: 375,
        height: 667,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final iPhone678Landscape = Device('iPhone 6/7/8',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    viewport: DeviceViewport(
        width: 667,
        height: 375,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const iPhone678Plus = Device('iPhone 6/7/8 Plus',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    viewport: DeviceViewport(
        width: 414,
        height: 736,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final iPhone678PlusLandscape = Device('iPhone 6/7/8 Plus',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    viewport: DeviceViewport(
        width: 736,
        height: 414,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const iPhoneX = Device('iPhone X',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    viewport: DeviceViewport(
        width: 375,
        height: 812,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final iPhoneXLandscape = Device('iPhone X',
    userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    viewport: DeviceViewport(
        width: 812,
        height: 375,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const blackBerryZ30 = Device('BlackBerry Z30',
    userAgent:
        'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.10+ (KHTML, like Gecko) Version/10.0.9.2372 Mobile Safari/537.10+',
    viewport: DeviceViewport(
        width: 360,
        height: 640,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final blackBerryZ30Landscape = Device('BlackBerry Z30',
    userAgent:
        'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.10+ (KHTML, like Gecko) Version/10.0.9.2372 Mobile Safari/537.10+',
    viewport: DeviceViewport(
        width: 640,
        height: 360,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const nexus4 = Device('Nexus 4',
    userAgent:
        'Mozilla/5.0 (Linux; Android 4.4.2; Nexus 4 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 384,
        height: 640,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final nexus4Landscape = Device('Nexus 4',
    userAgent:
        'Mozilla/5.0 (Linux; Android 4.4.2; Nexus 4 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 640,
        height: 384,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const nexus5 = Device('Nexus 5',
    userAgent:
        'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 360,
        height: 640,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final nexus5Landscape = Device('Nexus 5',
    userAgent:
        'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 640,
        height: 360,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const nexus5X = Device('Nexus 5X',
    userAgent:
        'Mozilla/5.0 (Linux; Android 8.0.0; Nexus 5X Build/OPR4.170623.006) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 412,
        height: 732,
        deviceScaleFactor: 2.625,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final nexus5XLandscape = Device('Nexus 5X',
    userAgent:
        'Mozilla/5.0 (Linux; Android 8.0.0; Nexus 5X Build/OPR4.170623.006) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 732,
        height: 412,
        deviceScaleFactor: 2.625,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const nexus6 = Device('Nexus 6',
    userAgent:
        'Mozilla/5.0 (Linux; Android 7.1.1; Nexus 6 Build/N6F26U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 412,
        height: 732,
        deviceScaleFactor: 3.5,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final nexus6Landscape = Device('Nexus 6',
    userAgent:
        'Mozilla/5.0 (Linux; Android 7.1.1; Nexus 6 Build/N6F26U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 732,
        height: 412,
        deviceScaleFactor: 3.5,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const nexus6P = Device('Nexus 6P',
    userAgent:
        'Mozilla/5.0 (Linux; Android 8.0.0; Nexus 6P Build/OPP3.170518.006) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 412,
        height: 732,
        deviceScaleFactor: 3.5,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final nexus6PLandscape = Device('Nexus 6P',
    userAgent:
        'Mozilla/5.0 (Linux; Android 8.0.0; Nexus 6P Build/OPP3.170518.006) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 732,
        height: 412,
        deviceScaleFactor: 3.5,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const pixel2 = Device('Pixel 2',
    userAgent:
        'Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 411,
        height: 731,
        deviceScaleFactor: 2.625,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final pixel2Landscape = Device('Pixel 2',
    userAgent:
        'Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 731,
        height: 411,
        deviceScaleFactor: 2.625,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const pixel2XL = Device('Pixel 2 XL',
    userAgent:
        'Mozilla/5.0 (Linux; Android 8.0.0; Pixel 2 XL Build/OPD1.170816.004) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 411,
        height: 823,
        deviceScaleFactor: 3.5,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final pixel2XLLandscape = Device('Pixel 2 XL',
    userAgent:
        'Mozilla/5.0 (Linux; Android 8.0.0; Pixel 2 XL Build/OPD1.170816.004) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 823,
        height: 411,
        deviceScaleFactor: 3.5,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const lGOptimusL70 = Device('LG Optimus L70',
    userAgent:
        'Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; LGMS323 Build/KOT49I.MS32310c) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 384,
        height: 640,
        deviceScaleFactor: 1.25,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final lGOptimusL70Landscape = Device('LG Optimus L70',
    userAgent:
        'Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; LGMS323 Build/KOT49I.MS32310c) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 640,
        height: 384,
        deviceScaleFactor: 1.25,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const nokiaN9 = Device('Nokia N9',
    userAgent:
        'Mozilla/5.0 (MeeGo; NokiaN9) AppleWebKit/534.13 (KHTML, like Gecko) NokiaBrowser/8.5.0 Mobile Safari/534.13',
    viewport: DeviceViewport(
        width: 480,
        height: 854,
        deviceScaleFactor: 1,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final nokiaN9Landscape = Device('Nokia N9',
    userAgent:
        'Mozilla/5.0 (MeeGo; NokiaN9) AppleWebKit/534.13 (KHTML, like Gecko) NokiaBrowser/8.5.0 Mobile Safari/534.13',
    viewport: DeviceViewport(
        width: 854,
        height: 480,
        deviceScaleFactor: 1,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const nokiaLumia520 = Device('Nokia Lumia 520',
    userAgent:
        'Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 520)',
    viewport: DeviceViewport(
        width: 320,
        height: 533,
        deviceScaleFactor: 1.5,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final nokiaLumia520Landscape = Device('Nokia Lumia 520',
    userAgent:
        'Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 520)',
    viewport: DeviceViewport(
        width: 533,
        height: 320,
        deviceScaleFactor: 1.5,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const microsoftLumia550 = Device('Microsoft Lumia 550',
    userAgent:
        'Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; Microsoft; Lumia 550) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Mobile Safari/537.36 Edge/14.14263',
    viewport: DeviceViewport(
        width: 640,
        height: 360,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final microsoftLumia550Landscape = Device('Microsoft Lumia 550',
    userAgent:
        'Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; Microsoft; Lumia 550) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Mobile Safari/537.36 Edge/14.14263',
    viewport: DeviceViewport(
        width: 640,
        height: 360,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const microsoftLumia950 = Device('Microsoft Lumia 950',
    userAgent:
        'Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; Microsoft; Lumia 950) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Mobile Safari/537.36 Edge/14.14263',
    viewport: DeviceViewport(
        width: 360,
        height: 640,
        deviceScaleFactor: 4,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final microsoftLumia950Landscape = Device('Microsoft Lumia 950',
    userAgent:
        'Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; Microsoft; Lumia 950) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Mobile Safari/537.36 Edge/14.14263',
    viewport: DeviceViewport(
        width: 640,
        height: 360,
        deviceScaleFactor: 4,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const galaxySIII = Device('Galaxy S III',
    userAgent:
        'Mozilla/5.0 (Linux; U; Android 4.0; en-us; GT-I9300 Build/IMM76D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
    viewport: DeviceViewport(
        width: 360,
        height: 640,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final galaxySIIILandscape = Device('Galaxy S III',
    userAgent:
        'Mozilla/5.0 (Linux; U; Android 4.0; en-us; GT-I9300 Build/IMM76D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
    viewport: DeviceViewport(
        width: 640,
        height: 360,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const galaxyS5 = Device('Galaxy S5',
    userAgent:
        'Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 360,
        height: 640,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final galaxyS5Landscape = Device('Galaxy S5',
    userAgent:
        'Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Mobile Safari/537.36',
    viewport: DeviceViewport(
        width: 640,
        height: 360,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const jioPhone2 = Device('JioPhone 2',
    userAgent:
        'Mozilla/5.0 (Mobile; LYF/F300B/LYF-F300B-001-01-15-130718-i;Android; rv:48.0) Gecko/48.0 Firefox/48.0 KAIOS/2.5',
    viewport: DeviceViewport(
        width: 240,
        height: 320,
        deviceScaleFactor: 1,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final jioPhone2Landscape = Device('JioPhone 2',
    userAgent:
        'Mozilla/5.0 (Mobile; LYF/F300B/LYF-F300B-001-01-15-130718-i;Android; rv:48.0) Gecko/48.0 Firefox/48.0 KAIOS/2.5',
    viewport: DeviceViewport(
        width: 320,
        height: 240,
        deviceScaleFactor: 1,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const kindleFireHDX = Device('Kindle Fire HDX',
    userAgent:
        'Mozilla/5.0 (Linux; U; en-us; KFAPWI Build/JDQ39) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.13 Safari/535.19 Silk-Accelerated=true',
    viewport: DeviceViewport(
        width: 800,
        height: 1280,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final kindleFireHDXLandscape = Device('Kindle Fire HDX',
    userAgent:
        'Mozilla/5.0 (Linux; U; en-us; KFAPWI Build/JDQ39) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.13 Safari/535.19 Silk-Accelerated=true',
    viewport: DeviceViewport(
        width: 1280,
        height: 800,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const iPadMini = Device('iPad Mini',
    userAgent:
        'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
    viewport: DeviceViewport(
        width: 768,
        height: 1024,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final iPadMiniLandscape = Device('iPad Mini',
    userAgent:
        'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
    viewport: DeviceViewport(
        width: 1024,
        height: 768,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const iPad = Device('iPad',
    userAgent:
        'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
    viewport: DeviceViewport(
        width: 768,
        height: 1024,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final iPadLandscape = Device('iPad',
    userAgent:
        'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
    viewport: DeviceViewport(
        width: 1024,
        height: 768,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const iPadPro = Device('iPad Pro',
    userAgent:
        'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
    viewport: DeviceViewport(
        width: 1024,
        height: 1366,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final iPadProLandscape = Device('iPad Pro',
    userAgent:
        'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
    viewport: DeviceViewport(
        width: 1366,
        height: 1024,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const blackberryPlayBook = Device('Blackberry PlayBook',
    userAgent:
        'Mozilla/5.0 (PlayBook; U; RIM Tablet OS 2.1.0; en-US) AppleWebKit/536.2+ (KHTML like Gecko) Version/7.2.1.0 Safari/536.2+',
    viewport: DeviceViewport(
        width: 600,
        height: 1024,
        deviceScaleFactor: 1,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final blackberryPlayBookLandscape = Device('Blackberry PlayBook',
    userAgent:
        'Mozilla/5.0 (PlayBook; U; RIM Tablet OS 2.1.0; en-US) AppleWebKit/536.2+ (KHTML like Gecko) Version/7.2.1.0 Safari/536.2+',
    viewport: DeviceViewport(
        width: 1024,
        height: 600,
        deviceScaleFactor: 1,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const nexus10 = Device('Nexus 10',
    userAgent:
        'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 10 Build/MOB31T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Safari/537.36',
    viewport: DeviceViewport(
        width: 800,
        height: 1280,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final nexus10Landscape = Device('Nexus 10',
    userAgent:
        'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 10 Build/MOB31T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Safari/537.36',
    viewport: DeviceViewport(
        width: 1280,
        height: 800,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const nexus7 = Device('Nexus 7',
    userAgent:
        'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 7 Build/MOB30X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Safari/537.36',
    viewport: DeviceViewport(
        width: 600,
        height: 960,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final nexus7Landscape = Device('Nexus 7',
    userAgent:
        'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 7 Build/MOB30X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/%s Safari/537.36',
    viewport: DeviceViewport(
        width: 960,
        height: 600,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const galaxyNote3 = Device('Galaxy Note 3',
    userAgent:
        'Mozilla/5.0 (Linux; U; Android 4.3; en-us; SM-N900T Build/JSS15J) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
    viewport: DeviceViewport(
        width: 360,
        height: 640,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final galaxyNote3Landscape = Device('Galaxy Note 3',
    userAgent:
        'Mozilla/5.0 (Linux; U; Android 4.3; en-us; SM-N900T Build/JSS15J) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
    viewport: DeviceViewport(
        width: 640,
        height: 360,
        deviceScaleFactor: 3,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const galaxyNoteII = Device('Galaxy Note II',
    userAgent:
        'Mozilla/5.0 (Linux; U; Android 4.1; en-us; GT-N7100 Build/JRO03C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
    viewport: DeviceViewport(
        width: 360,
        height: 640,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: false));

final galaxyNoteIILandscape = Device('Galaxy Note II',
    userAgent:
        'Mozilla/5.0 (Linux; U; Android 4.1; en-us; GT-N7100 Build/JRO03C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
    viewport: DeviceViewport(
        width: 640,
        height: 360,
        deviceScaleFactor: 2,
        isMobile: true,
        hasTouch: true,
        isLandscape: true));

const laptopWithTouch = Device('Laptop with touch',
    userAgent: '',
    viewport: DeviceViewport(
        width: 950,
        height: 1280,
        deviceScaleFactor: 1,
        isMobile: false,
        hasTouch: true,
        isLandscape: false));

final laptopWithTouchLandscape = Device('Laptop with touch',
    userAgent: '',
    viewport: DeviceViewport(
        width: 1280,
        height: 950,
        deviceScaleFactor: 1,
        isMobile: false,
        hasTouch: true,
        isLandscape: true));

const laptopWithHiDPIScreen = Device('Laptop with HiDPI screen',
    userAgent: '',
    viewport: DeviceViewport(
        width: 900,
        height: 1440,
        deviceScaleFactor: 2,
        isMobile: false,
        hasTouch: false,
        isLandscape: false));

final laptopWithHiDPIScreenLandscape = Device('Laptop with HiDPI screen',
    userAgent: '',
    viewport: DeviceViewport(
        width: 1440,
        height: 900,
        deviceScaleFactor: 2,
        isMobile: false,
        hasTouch: false,
        isLandscape: true));

const laptopWithMDPIScreen = Device('Laptop with MDPI screen',
    userAgent: '',
    viewport: DeviceViewport(
        width: 800,
        height: 1280,
        deviceScaleFactor: 1,
        isMobile: false,
        hasTouch: false,
        isLandscape: false));

final laptopWithMDPIScreenLandscape = Device('Laptop with MDPI screen',
    userAgent: '',
    viewport: DeviceViewport(
        width: 1280,
        height: 800,
        deviceScaleFactor: 1,
        isMobile: false,
        hasTouch: false,
        isLandscape: true));
