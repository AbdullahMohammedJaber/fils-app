// ignore_for_file: unused_element, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/language/language_cubit.dart';
import 'package:fils/managment/language/language_state.dart';
import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/storage.dart';
import '../../utils/widget/defulat_text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FloatingButtonController>(context, listen: false).hide();
    });*/
    return BlocConsumer<LanguageCubit,LanguageState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heigth * 0.06),
                  ItemTitleBar(title: "About Us".tr(), canBack: true),
                  SizedBox(height: heigth * 0.05),
                  getLang() == 'ar'
                      ? const DefaultText(
                        '''
    انطلقت فِلْس العالمية من الكويت كمبادرة طموحة في عام 2024 من مؤسسين شغوفين بالتجارة الرقمية، لتتحول إلى منصة متطورة تمكّن المستخدمين من البيع والشراء والمشاركة في المزادات عبر تطبيق يدعم خمس لغات، ويجمع بين الذكاء التقني وسهولة الاستخدام، بهدف تقريب المسافات وخلق تجربة تسوق موثوقة وفعالة.
    
    نُسهل على الجميع، سواء أفراد أو تجار، الوصول إلى عالم التجارة الإلكترونية من خلال منصة موثوقة ومتعددة اللغات، تربط الأسواق المحلية والإقليمية، وتدمج بين التسوق والمزادات، وتبني جسورًا من الشفافية والتفاعل الفعّال.
    
    نتطلّع لأن نصبح الاسم الكويتي الأبرز في مجال التجارة الرقمية، حيث تُدار العمليات التجارية بذكاء وشفافية، وتُدار المزادات بخوارزميات دقيقة، ضمن بيئة تكنولوجية تُعزز فرص النمو وتُلهِم روّاد الأعمال والمستهلكين على حد سواء.
    
    
     ''',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.justify,
                      )
                      : getLang() == 'en'
                      ? const DefaultText(
                        '''
    
    In 2024, Fils Global was launched from Kuwait as an ambitious initiative by founders passionate about digital commerce. It has since evolved into a sophisticated platform that empowers users to buy, sell, and participate in auctions through a multilingual app supporting five languages, designed to merge technological intelligence with ease of use — aiming to bridge distances and offer a reliable and efficient shopping experience.
    
    We simplify access to the world of e-commerce for everyone — individuals and merchants alike — through a trusted, multilingual platform that connects local and regional markets. By combining shopping and auctions, we create a transparent and highly interactive environment.
    
    Our vision is to become Kuwait’s leading name in digital commerce where transactions are smart and transparent, auctions are run by precise algorithms, and the entire ecosystem fosters growth and inspires both entrepreneurs and consumers.
    ''',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.justify,
                      )
                      : getLang() == 'hi'
                      ? const DefaultText(
                        '''
    
    2024 में, डिजिटल कॉमर्स के प्रति जुनूनी संस्थापकों द्वारा एक महत्वाकांक्षी पहल के रूप में, फिल्स ग्लोबल को कुवैत से लॉन्च किया गया था। तब से यह एक परिष्कृत प्लेटफ़ॉर्म के रूप में विकसित हुआ है जो उपयोगकर्ताओं को पाँच भाषाओं में समर्थित एक बहुभाषी ऐप के माध्यम से खरीदारी, बिक्री और नीलामी में भाग लेने की सुविधा प्रदान करता है। इसे तकनीकी बुद्धिमत्ता को उपयोग में आसानी के साथ जोड़ने के लिए डिज़ाइन किया गया है - जिसका उद्देश्य दूरियों को पाटना और एक विश्वसनीय और कुशल खरीदारी अनुभव प्रदान करना है।
    
    हम स्थानीय और क्षेत्रीय बाज़ारों को जोड़ने वाले एक विश्वसनीय, बहुभाषी प्लेटफ़ॉर्म के माध्यम से सभी के लिए - व्यक्तियों और व्यापारियों दोनों के लिए - ई-कॉमर्स की दुनिया तक पहुँच को आसान बनाते हैं। खरीदारी और नीलामी को मिलाकर, हम एक पारदर्शी और अत्यधिक इंटरैक्टिव वातावरण बनाते हैं।
    
    हमारा लक्ष्य डिजिटल कॉमर्स में कुवैत का अग्रणी नाम बनना है जहाँ लेनदेन स्मार्ट और पारदर्शी हों, नीलामी सटीक एल्गोरिदम द्वारा संचालित हों, और पूरा पारिस्थितिकी तंत्र विकास को बढ़ावा दे और उद्यमियों और उपभोक्ताओं दोनों को प्रेरित करे।
    ''',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.justify,
                      )
                      : getLang() == 'fa'
                      ? const DefaultText(
                        '''
    در سال ۲۰۲۴، Fils Global از کویت به عنوان یک ابتکار بلندپروازانه توسط بنیانگذارانی که به تجارت دیجیتال علاقه داشتند، راه‌اندازی شد. از آن زمان به یک پلتفرم پیشرفته تبدیل شده است که به کاربران این امکان را می‌دهد تا از طریق یک برنامه چندزبانه که از پنج زبان پشتیبانی می‌کند، خرید، فروش و در حراجی‌ها شرکت کنند. این برنامه برای ادغام هوش فناوری با سهولت استفاده طراحی شده است - با هدف از بین بردن فواصل و ارائه یک تجربه خرید قابل اعتماد و کارآمد.
    
    ما از طریق یک پلتفرم چندزبانه و قابل اعتماد که بازارهای محلی و منطقه‌ای را به هم متصل می‌کند، دسترسی به دنیای تجارت الکترونیک را برای همه - افراد و بازرگانان - ساده می‌کنیم. با ترکیب خرید و حراجی‌ها، یک محیط شفاف و بسیار تعاملی ایجاد می‌کنیم.
    
    چشم‌انداز ما این است که به نام پیشرو کویت در تجارت دیجیتال تبدیل شویم که در آن معاملات هوشمند و شفاف هستند، حراجی‌ها توسط الگوریتم‌های دقیق اجرا می‌شوند و کل اکوسیستم رشد را تقویت می‌کند و هم کارآفرینان و هم مصرف‌کنندگان را الهام می‌بخشد.
    ''',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.justify,
                      )
                      : const DefaultText(
                        '''
    2024 میں، Fils Global کو کویت سے ڈیجیٹل کامرس کے لیے پرجوش بانیوں کی جانب سے ایک پرجوش اقدام کے طور پر شروع کیا گیا۔ اس کے بعد سے یہ ایک نفیس پلیٹ فارم میں تیار ہوا ہے جو صارفین کو پانچ زبانوں کی حمایت کرنے والی کثیر لسانی ایپ کے ذریعے خریدنے، فروخت کرنے اور نیلامی میں حصہ لینے کا اختیار دیتا ہے، جو کہ تکنیکی ذہانت کو استعمال میں آسانی کے ساتھ ضم کرنے کے لیے ڈیزائن کیا گیا ہے - جس کا مقصد فاصلے کو کم کرنا اور ایک قابل اعتماد اور موثر خریداری کا تجربہ پیش کرنا ہے۔
    
    ہم ایک بھروسہ مند، کثیر لسانی پلیٹ فارم کے ذریعے جو کہ مقامی اور علاقائی منڈیوں کو جوڑتا ہے، سبھی کے لیے ای کامرس کی دنیا تک رسائی کو آسان بناتے ہیں — افراد اور تاجر ایک جیسے۔ خریداری اور نیلامی کو یکجا کرکے، ہم ایک شفاف اور انتہائی متعامل ماحول بناتے ہیں۔
    
    ہمارا وژن ڈیجیٹل کامرس میں کویت کا سرکردہ نام بننا ہے جہاں لین دین ہوشیار اور شفاف ہوں، نیلامی درست الگورتھم کے ذریعے چلائی جاتی ہے، اور پورا ماحولیاتی نظام ترقی کو فروغ دیتا ہے اور تاجروں اور صارفین دونوں کو متاثر کرتا ہے۔
    ''',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.justify,
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*  WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FloatingButtonController>(context, listen: false).hide();
    });*/
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: heigth * 0.06),
              ItemTitleBar(title: "Privacy Policy".tr(), canBack: true),
              SizedBox(height: heigth * 0.05),
              getLang() == 'ar'
                  ? const DefaultText(
                    '''
* سياسة الخصوصية

تاريخ السريان: 01/01/2028
آخر تحديث: 06/26/2025

توضح هذه الوثيقة ("سياسة الخصوصية") الإجراءات التي نتبعها أثناء قيامنا بجمع ومعالجة واستخدام المعلومات الشخصية للأفراد والمستخدمين الآخرين فيما يتعلق بمنصتنا.

تدير شركة فلس ("نحن"، "لنا" أو "الشركة") تطبيق "فلس" وتقدم من خلاله المحتوى، الميزات، والخدمات ("الخدمات") بشكل جماعي.

من خلال استخدام التطبيق أو اختيارك لأي من خدماتنا، فإنك توافق على شروط وأحكام سياسة الخصوصية هذه.

إذا لم تكن توافق على هذه السياسة، يُرجى عدم استخدام المنصة.

1. قبول سياسة الخصوصية:
   تُعد هذه السياسة جزءًا لا يتجزأ من شروط الخدمة. باستخدامك المنصة، فأنت تقر بموافقتك على هذه السياسة.

أ. المعلومات التي يقدمها المستخدمون بموافقتهم.
ب. يجب أن يكون المستخدم على علم بأن التطبيق قد يحتوي على روابط تؤدي إلى مواقع تابعة لأطراف ثالثة.
ج. يُنصح المستخدمون بشدة بالاطلاع على سياسات الخصوصية الخاصة بتلك الأطراف قبل استخدامها.

2. المعلومات التي نقوم بجمعها:
   عند استخدامك للمنصة، قد نقوم بجمع المعلومات التالية:
   أ. المعلومات الشخصية التي تقدمها لنا مثل الاسم، البريد الإلكتروني، رقم الهاتف، وغيرها عند إنشاء حساب.
   ب. معلومات تُجمع تلقائيًا مثل عنوان IP، الجهاز، نظام التشغيل، الوقت والتاريخ.

3. كيف نستخدم معلوماتك:
   نستخدم معلوماتك الشخصية لتوفير الخدمات، صيانتها، تحسينها، التواصل معك، وإرسال إشعارات متعلقة بحسابك.

4. كيف نشارك معلوماتك:
   نشارك معلوماتك فقط عند الضرورة، مثل:

* مع مزودي الخدمات لتشغيل المنصة.
* عندما يتطلب القانون ذلك.

5. الأمان:
   نُطبق تدابير أمنية مناسبة لحماية معلوماتك، لكن لا يمكننا ضمان أمان كامل بنسبة 100%.

6. حقوقك:
   لديك الحق في الوصول إلى بياناتك وتصحيحها أو حذفها، وطلب التوقف عن استخدام معلوماتك.

7. تعديل سياسة الخصوصية:
   يجوز لنا تعديل سياسة الخصوصية من وقت لآخر، وسيتم إشعارك بأي تغييرات من خلال المنصة.

8. الاتصال بنا:
   للاستفسارات أو الشكاوى، يمكنك التواصل معنا عبر البريد الإلكتروني: fils.business@hotmail.com

بالدخول إلى المنصة أو استخدامها بعد تاريخ التحديث، فإنك توافق على السياسة المعدّلة.
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  )
                  : getLang() == 'en'
                  ? const DefaultText(
                    '''
* Privacy Policy

Effective Date: 01/01/2028
Last Updated: 06/26/2025

This document ("Privacy Policy") outlines the procedures we follow while collecting, processing, and using personal information of individuals and other users in relation to our platform.

Fils Company ("we", "us" or "the company") operates the "Fils" application and provides, through it, the content, features, and services ("services") collectively.

By using the application or selecting any of our services, you agree to the terms and conditions of this Privacy Policy.

If you do not agree to this policy, please do not use the platform.

1. Acceptance of the Privacy Policy:  
   This policy is an integral part of the Terms of Service. By using the platform, you acknowledge your agreement to this policy.

A. Information provided by users with their consent.  
B. The user should be aware that the app may contain links to third-party websites.  
C. Users are strongly advised to review the privacy policies of those third parties before using them.

2. Information We Collect:  
   When using the platform, we may collect the following information:  
   A. Personal information you provide to us, such as name, email address, phone number, etc., when creating an account.  
   B. Information collected automatically such as IP address, device, operating system, time and date.

3. How We Use Your Information:  
   We use your personal information to provide, maintain, and improve our services, communicate with you, and send notifications related to your account.

4. How We Share Your Information:  
   We only share your information when necessary, such as:

* With service providers to operate the platform.  
* When required by law.

5. Security:  
   We implement appropriate security measures to protect your information, but we cannot guarantee 100% complete security.

6. Your Rights:  
   You have the right to access, correct, or delete your data, and request us to stop using or sharing your information.

7. Changes to the Privacy Policy:  
   We may update the Privacy Policy from time to time, and you will be notified of any changes through the platform.

8. Contact Us:  
   For inquiries or complaints, you can contact us via email: fils.business@hotmail.com

By accessing or using the platform after the update date, you agree to the revised policy.
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  )
                  : getLang() == 'hi'
                  ? const DefaultText(
                    '''
* गोपनीयता नीति

प्रभावी तिथि: 01/01/2028
अंतिम अद्यतन: 06/26/2025

यह दस्तावेज़ ("गोपनीयता नीति") हमारे प्लेटफ़ॉर्म के संबंध में व्यक्तियों और अन्य उपयोगकर्ताओं की व्यक्तिगत जानकारी एकत्रित करने, संसाधित करने और उसका उपयोग करने के दौरान हमारे द्वारा अपनाई जाने वाली प्रक्रियाओं की रूपरेखा प्रस्तुत करता है।

Fils कंपनी ("हम", "हमें" या "कंपनी") "Fils" एप्लिकेशन का संचालन करती है और इसके माध्यम से सामूहिक रूप से सामग्री, सुविधाएँ और सेवाएँ ("सेवाएँ") प्रदान करती है।

एप्लिकेशन का उपयोग करके या हमारी किसी भी सेवा का चयन करके, आप इस गोपनीयता नीति के नियमों और शर्तों से सहमत होते हैं।

यदि आप इस नीति से सहमत नहीं हैं, तो कृपया प्लेटफ़ॉर्म का उपयोग न करें।

1. गोपनीयता नीति की स्वीकृति:
यह नीति सेवा की शर्तों का एक अभिन्न अंग है। प्लेटफ़ॉर्म का उपयोग करके, आप इस नीति से अपनी सहमति स्वीकार करते हैं।

A. उपयोगकर्ताओं द्वारा उनकी सहमति से प्रदान की गई जानकारी।
B. उपयोगकर्ता को पता होना चाहिए कि ऐप में तृतीय-पक्ष वेबसाइटों के लिंक हो सकते हैं।

C. उपयोगकर्ताओं को सलाह दी जाती है कि वे इन तृतीय पक्षों का उपयोग करने से पहले उनकी गोपनीयता नीतियों की समीक्षा कर लें।

2. हमारे द्वारा एकत्रित की जाने वाली जानकारी:
प्लेटफ़ॉर्म का उपयोग करते समय, हम निम्नलिखित जानकारी एकत्रित कर सकते हैं:
A. खाता बनाते समय आपके द्वारा हमें प्रदान की गई व्यक्तिगत जानकारी, जैसे नाम, ईमेल पता, फ़ोन नंबर आदि।
B. स्वचालित रूप से एकत्रित की जाने वाली जानकारी, जैसे IP पता, डिवाइस, ऑपरेटिंग सिस्टम, समय और दिनांक।

3. हम आपकी जानकारी का उपयोग कैसे करते हैं:
हम आपकी व्यक्तिगत जानकारी का उपयोग अपनी सेवाएँ प्रदान करने, उन्हें बनाए रखने और बेहतर बनाने, आपसे संवाद करने और आपके खाते से संबंधित सूचनाएँ भेजने के लिए करते हैं।

4. हम आपकी जानकारी कैसे साझा करते हैं:
हम आपकी जानकारी केवल तभी साझा करते हैं जब आवश्यक हो, जैसे:

* प्लेटफ़ॉर्म संचालित करने के लिए सेवा प्रदाताओं के साथ।
* जब कानून द्वारा आवश्यक हो।

5. सुरक्षा:
हम आपकी जानकारी की सुरक्षा के लिए उचित सुरक्षा उपाय लागू करते हैं, लेकिन हम 100% पूर्ण सुरक्षा की गारंटी नहीं दे सकते।

6. आपके अधिकार:
आपको अपने डेटा तक पहुँचने, उसे सही करने या उसे हटाने का अधिकार है, और आप हमसे अपनी जानकारी का उपयोग या साझा करना बंद करने का अनुरोध कर सकते हैं।

7. गोपनीयता नीति में परिवर्तन:
हम समय-समय पर गोपनीयता नीति को अपडेट कर सकते हैं, और आपको प्लेटफ़ॉर्म के माध्यम से किसी भी बदलाव की सूचना दी जाएगी।

8. हमसे संपर्क करें:
पूछताछ या शिकायतों के लिए, आप हमें ईमेल के माध्यम से संपर्क कर सकते हैं: fils.business@hotmail.com

अपडेट तिथि के बाद प्लेटफ़ॉर्म पर पहुँचकर या उसका उपयोग करके, आप संशोधित नीति से सहमत होते हैं।
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  )
                  : getLang() == 'fa'
                  ? const DefaultText(
                    '''
* سیاست حفظ حریم خصوصی

تاریخ اجرا: 01/01/2028
آخرین به‌روزرسانی: 06/26/2025

این سند ("سیاست حفظ حریم خصوصی") رویه‌هایی را که ما هنگام جمع‌آوری، پردازش و استفاده از اطلاعات شخصی افراد و سایر کاربران در رابطه با پلتفرم خود دنبال می‌کنیم، تشریح می‌کند.

شرکت فیلز ("ما" یا "شرکت") برنامه "فیلز" را اداره می‌کند و از طریق آن، محتوا، ویژگی‌ها و خدمات ("خدمات") را به صورت جمعی ارائه می‌دهد.

با استفاده از برنامه یا انتخاب هر یک از خدمات ما، شما با شرایط و ضوابط این سیاست حفظ حریم خصوصی موافقت می‌کنید.

اگر با این سیاست موافق نیستید، لطفاً از پلتفرم استفاده نکنید.

1. پذیرش سیاست حفظ حریم خصوصی:

این سیاست بخش جدایی‌ناپذیری از شرایط خدمات است. با استفاده از پلتفرم، شما موافقت خود را با این سیاست اعلام می‌کنید.

الف. اطلاعات ارائه شده توسط کاربران با رضایت آنها.

ب. کاربر باید آگاه باشد که برنامه ممکن است حاوی لینک‌هایی به وب‌سایت‌های شخص ثالث باشد.

ج. به کاربران اکیداً توصیه می‌شود قبل از استفاده از اشخاص ثالث، سیاست‌های حفظ حریم خصوصی آنها را بررسی کنند.


۲. اطلاعاتی که ما جمع‌آوری می‌کنیم:

هنگام استفاده از پلتفرم، ممکن است اطلاعات زیر را جمع‌آوری کنیم:

الف. اطلاعات شخصی که شما هنگام ایجاد حساب کاربری در اختیار ما قرار می‌دهید، مانند نام، آدرس ایمیل، شماره تلفن و غیره.

ب. اطلاعاتی که به طور خودکار جمع‌آوری می‌شوند مانند آدرس IP، دستگاه، سیستم عامل، زمان و تاریخ.


۳. نحوه استفاده ما از اطلاعات شما:

ما از اطلاعات شخصی شما برای ارائه، نگهداری و بهبود خدمات خود، ارتباط با شما و ارسال اعلان‌های مربوط به حساب شما استفاده می‌کنیم.


۴. نحوه اشتراک‌گذاری اطلاعات شما:

ما فقط در صورت لزوم، اطلاعات شما را به اشتراک می‌گذاریم، مانند:

* با ارائه دهندگان خدمات برای اداره پلتفرم.

* در صورت الزام قانونی.


۵. امنیت:
ما اقدامات امنیتی مناسبی را برای محافظت از اطلاعات شما اجرا می‌کنیم، اما نمی‌توانیم امنیت ۱۰۰٪ کامل را تضمین کنیم.


۶. حقوق شما:
شما حق دسترسی، اصلاح یا حذف داده‌های خود را دارید و از ما می‌خواهید که استفاده یا اشتراک‌گذاری اطلاعات شما را متوقف کنیم.

7. تغییرات در سیاست حفظ حریم خصوصی:

ما ممکن است سیاست حفظ حریم خصوصی را هر از گاهی به‌روزرسانی کنیم و شما از طریق پلتفرم از هرگونه تغییر مطلع خواهید شد.

8. تماس با ما:

برای سوالات یا شکایات، می‌توانید از طریق ایمیل fils.business@hotmail.com با ما تماس بگیرید.

با دسترسی یا استفاده از پلتفرم پس از تاریخ به‌روزرسانی، شما با سیاست اصلاح‌شده موافقت می‌کنید.
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  )
                  : const DefaultText(
                    '''
* رازداری کی پالیسی

مؤثر تاریخ: 01/01/2028
آخری اپ ڈیٹ: 06/26/2025

یہ دستاویز ("پرائیویسی پالیسی") ان طریقہ کار کا خاکہ پیش کرتی ہے جن کی پیروی ہم اپنے پلیٹ فارم کے سلسلے میں افراد اور دیگر صارفین کی ذاتی معلومات کو جمع کرنے، پروسیسنگ کرنے اور استعمال کرنے کے دوران کرتے ہیں۔

Fils کمپنی ("ہم"، "ہم" یا "کمپنی") "فلز" ایپلیکیشن چلاتی ہے اور اس کے ذریعے، مواد، خصوصیات، اور خدمات ("خدمات") کو اجتماعی طور پر فراہم کرتی ہے۔

ایپلیکیشن استعمال کرکے یا ہماری کسی بھی خدمات کو منتخب کرکے، آپ اس رازداری کی پالیسی کی شرائط و ضوابط سے اتفاق کرتے ہیں۔

اگر آپ اس پالیسی سے متفق نہیں ہیں، تو براہ کرم پلیٹ فارم استعمال نہ کریں۔

1. رازداری کی پالیسی کی قبولیت: 
یہ پالیسی سروس کی شرائط کا ایک لازمی حصہ ہے۔ پلیٹ فارم کا استعمال کرکے، آپ اس پالیسی سے اپنے معاہدے کو تسلیم کرتے ہیں۔

A. صارفین کی جانب سے ان کی رضامندی سے فراہم کردہ معلومات۔
B. صارف کو آگاہ ہونا چاہیے کہ ایپ میں فریق ثالث کی ویب سائٹس کے لنکس ہو سکتے ہیں۔
C. صارفین کو سختی سے مشورہ دیا جاتا ہے کہ وہ استعمال کرنے سے پہلے ان تیسرے فریق کی رازداری کی پالیسیوں کا جائزہ لیں۔

2. معلومات ہم جمع کرتے ہیں: 
پلیٹ فارم استعمال کرتے وقت، ہم درج ذیل معلومات جمع کر سکتے ہیں: 
A. اکاؤنٹ بناتے وقت جو ذاتی معلومات آپ ہمیں فراہم کرتے ہیں، جیسے نام، ای میل پتہ، فون نمبر وغیرہ۔ 
B. معلومات خود بخود جمع کی جاتی ہیں جیسے IP ایڈریس، ڈیوائس، آپریٹنگ سسٹم، وقت اور تاریخ۔

3. ہم آپ کی معلومات کو کس طرح استعمال کرتے ہیں: 
ہم آپ کی ذاتی معلومات کو اپنی خدمات فراہم کرنے، برقرار رکھنے اور بہتر بنانے، آپ کے ساتھ بات چیت کرنے، اور آپ کے اکاؤنٹ سے متعلق اطلاعات بھیجنے کے لیے استعمال کرتے ہیں۔

4. ہم آپ کی معلومات کا اشتراک کیسے کریں: 
ہم آپ کی معلومات صرف اس وقت شیئر کرتے ہیں جب ضروری ہو، جیسے:

* پلیٹ فارم کو چلانے کے لیے سروس فراہم کرنے والوں کے ساتھ۔
* جب قانون کی ضرورت ہو۔

5. سیکورٹی: 
ہم آپ کی معلومات کی حفاظت کے لیے مناسب حفاظتی اقدامات نافذ کرتے ہیں، لیکن ہم 100% مکمل تحفظ کی ضمانت نہیں دے سکتے۔

6. آپ کے حقوق: 
آپ کو اپنے ڈیٹا تک رسائی، درست کرنے یا حذف کرنے کا حق ہے، اور ہم سے درخواست کریں کہ آپ اپنی معلومات کا استعمال یا اشتراک بند کریں۔

7. رازداری کی پالیسی میں تبدیلیاں: 
ہم وقتا فوقتا رازداری کی پالیسی کو اپ ڈیٹ کر سکتے ہیں، اور آپ کو پلیٹ فارم کے ذریعے کسی بھی تبدیلی کے بارے میں مطلع کیا جائے گا۔

8. ہم سے رابطہ کریں: 
پوچھ گچھ یا شکایات کے لیے، آپ ہم سے ای میل کے ذریعے رابطہ کر سکتے ہیں: fils.business@hotmail.com

اپ ڈیٹ کی تاریخ کے بعد پلیٹ فارم تک رسائی یا استعمال کرکے، آپ نظر ثانی شدہ پالیسی سے اتفاق کرتے ہیں۔
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class TermsAndCondation extends StatefulWidget {
  int id;
  TermsAndCondation(this.id);

  @override
  State<TermsAndCondation> createState() => _TermsAndCondationState();
}

class _TermsAndCondationState extends State<TermsAndCondation> {
  final ScrollController _scrollController = ScrollController();
  bool checkP = false;
  changeCheckP() async {
    if (checkP == true) {
      checkP = false;
    } else {
      checkP = true;

    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FloatingButtonController>(context, listen: false).hide();
    });
    return Consumer<AppNotifire>(
      builder: (context, value, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
              );
            },
            child: const Icon(Icons.arrow_downward),
          ),
          appBar: AppBar(automaticallyImplyLeading: false , toolbarHeight: 0),

          body: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, checkP);
                        },
                        child: SizedBox(
                          height: getLang() == 'ar' ? 25 : 23,
                          width: 30,
                          child: FlipView(
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/back.svg",
                                color: getTheme() ? white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: width * 0.01),
                      DefaultText(
                        getLang() == 'ar'
                            ? "شروط الخدمة (البائعين)"
                            : "Terms and Conditions (Sellers)".tr(),
                        color: primaryDarkColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: heigth * 0.05),
                  getLang() == 'ar'
                      ? const DefaultText(
                    '''
* شروط الخدمة (البائعين)

تاريخ السريان: 01/01/2028
آخر تحديث: 06/26/2025

تديره وتملكه شركة فلس كوكيل بالعمولة ("نحن"، "لنا"، "الشركة") والتي توفر منصة يلتقي فيها البائعون بالمشترين خلال مزادات شفافة ومنظمة بشكل جيد.
يشرفنا أن نوفر منصة يلتقي فيها البائعون الذين يعرضون منتجاتهم بالمشترين مباشرة.

بالتسجيل كبائع، فإنك توافق بالكامل على هذه الشروط وتؤكد فهمك للإجراءات المتعلقة بعرض المنتجات وبيعها على منصة فلس.

يرجى عدم التردد في التواصل معنا إذا كانت لديك أي أسئلة قبل المتابعة.

1. التعريفات:

- المنصة: تشير إلى التطبيق والموقع الإلكتروني المملوكين والمدارين من قبل شركة فلس، بما في ذلك جميع الخصائص والخدمات والأدوات المرتبطة بهما.
- المستخدم: أي شخص طبيعي أو اعتباري يقوم بإنشاء حساب على المنصة، سواء بائعًا أو مشتريًا أو مزايدًا، ويخضع لشروط هذه الخدمة.
- المزايد: المستخدم الذي يشارك في المزادات من خلال تقديم عروض على المنتجات المدرجة في المنصة.
- المشتري: المستخدم الذي يقوم بشراء منتج عبر المزاد أو البيع المباشر على المنصة.
- البائع: الشخص أو الكيان الذي يعرض منتجاته للبيع على المنصة، سواء مباشر أو عبر وكلاء فلس بالعمولة.
- الإدراج: أي إعلان أو عرض عن منتج يتم نشره من قبل البائع على المنصة.
- المزاد: آلية بيع تُعرض فيها المنتجات لفترة زمنية محددة، ويتم خلالها تقديم المزايدات، ويفوز بها صاحب أعلى عرض عند انتهاء المدة.
- المزايدة: العرض المالي الذي يقدمه المزايد خلال المزاد بهدف شراء المنتج.
- المزايد الرابح: المستخدم الذي قدم أعلى مزايدة عند انتهاء المزاد وتم إشعاره رسميًا بالفوز.
- البيع المباشر: عملية بيع تتيح للمشتري شراء المنتج فورًا بالسعر المحدد دون الدخول في مزاد.
- السعر الاحتياطي: الحد الأدنى من السعر الذي يحدده البائع، والذي يجب الوصول إليه أو تجاوزه حتى تُنفذ عملية البيع.
- الشراء الفوري: خيار يتيحه البائع لبيع المنتج بسعر محدد دون الانتظار لنهاية المزاد.
- المنتج: أي سلعة مادية أو رقمية يتم عرضها للبيع أو المزايدة على المنصة.
- مبلغ الضمان: مبلغ مالي تحتفظ به فلس مؤقتًا لضمان جدية المزايد، ويُرد وفقًا للشروط المذكورة.
- محفظة فلس: رصيد داخل التطبيق يُستخدم لإجراء المدفوعات داخل المنصة.
- الرصيد: القيمة المالية المتاحة التي يمكن للمستخدم استخدامها في محفظته الخاصة على المنصة.
- الرسوم الإدارية: أي مبالغ تستقطعها فلس مقابل إدارة المزاد أو معالجة بعض المعاملات.
- سياسة الإرجاع: مجموعة الشروط التي تحدد متى وكيف يمكن للمشتري إعادة المنتج واسترداد المبلغ المدفوع.
- النزاع: أي خلاف بين مستخدم وفلس أو بين مستخدمين آخرين يتعلق بالمنتج أو الخدمة أو شروط الاستخدام.
- الإشعار: أي رسالة رسمية يتم إرسالها عبر البريد الإلكتروني المرتبط بحساب المستخدم على المنصة.
- القانون الحاكم: القوانين المعمول بها في دولة الكويت والتي تُطبق على شروط هذه الخدمة وأي نزاع ينشأ عنها.
- المحتوى: جميع المعلومات أو النصوص أو الصور أو العروض أو البيانات المنشورة أو المقدمة من قبل المستخدم على المنصة.

2. الأهلية للبيع على المنصة:
- يجب أن يكون البائع كيانًا قانونيًا يعمل بشكل قانوني داخل دولة الكويت.
- يجوز للأفراد أو الشركات المسجلة أو المنشآت التجارية التي تحمل ترخيصًا تجاريًا ساريًا في الكويت البيع عبر المنصة.
- يجب أن يكون البائع مؤهلاً قانونيًا لإبرام الاتفاقيات والعقود وفقًا للقوانين الكويتية المعمول بها.

3. المنتجات المسموح بها والمقيدة:
- يجوز للبائعين عرض مجموعة واسعة من المنتجات شريطة أن تكون قانونية بموجب قوانين الكويت ومتوافقة مع النظام العام والآداب والمعايير المجتمعية.
- يُمنع إدراج المنتجات المحظورة دوليًا أو المقيدة بموجب القانون الكويتي أو التي تعتبر حساسة ثقافيًا أو قانونيًا.
- تحتفظ فلس بحق إزالة أي إدراج غير مناسب أو مخالف دون إشعار مسبق.

4. متطلبات إدراج المنتجات:
- يجب أن يتضمن كل إدراج وصفًا واضحًا وكاملاً للمنتج، بما في ذلك:
  أبعاد المنتج، وزنه، لونه، حالته (جديد/مستعمل)، بلد الصنع، أي عيوب أو مكونات مفقودة معروفة.
- يجب تحميل صور واضحة للمنتج الفعلي المعروض للبيع.
- يُمنع استخدام صور مضللة أو غير دقيقة أو مخزنة مسبقًا.

5. خيارات التسعير:
- السعر الاحتياطي: يجوز للبائع تحديد حد أدنى للسعر، ولا يقبل البيع دونه.
- سعر الشراء الفوري: يمكن للبائعين الذين يمتلكون متجرًا على المنصة تعيين سعر شراء فوري يتيح للعملاء شراء المنتج مباشرة دون الدخول في المزاد.

6. التعديلات والإلغاء:
- بمجرد تقديم مزايدة على إدراج نشط، لا يجوز للبائع تعديله أو إزالته.
- يجوز للبائع إلغاء الإدراج قبل استلام أي مزايدات من خلال لوحة التحكم الخاصة به.
- الإدراجات التي لا تتلقى مزايدات أو لا تصل إلى السعر الاحتياطي تنتهي صلاحيتها تلقائيًا وتُزال من المنصة.

7. الرسوم والعمولة:
- تفرض فلس رسومًا (نسبة أو مبلغ محدد) على كل عملية بيع مكتملة، وتُخصم من المبلغ النهائي المستحق للبائع.
- يتم عرض هيكل الرسوم بالكامل في لوحة التحكم الخاصة بالبائع، ويجب مراجعتها بعناية.
- يجوز لفلس تعديل هيكل الرسوم من حين لآخر، وتُطبق التعديلات على الإدراجات الجديدة فقط.

8. الدفع للبائعين:
- يتلقى البائعون المدفوعات خلال 21 يوم عمل بعد تسليم المنتج بنجاح وتأكيد حالته.
- إذا لم يؤكد المشتري الاستلام خلال الفترة المحددة، قد تقوم فلس بصرف المدفوعات وفقًا لتقديرها.

9. الشحن والتوصيل:
- يتحمل البائع المسؤولية الكاملة عن:
  إرسال المنتج في الوقت المناسب
  تغليف المنتج بشكل آمن
  تقديم تفاصيل التتبع (إن أمكن)
- يجوز للبائع تنفيذ التوصيل بنفسه، أو عبر مزود خدمة تابع له، أو من خلال شركاء التوصيل المعتمدين من فلس.

10. النزاعات والمسؤولية:
- تعمل فلس كمنصة لتسهيل الإدراجات والمدفوعات فقط، ولا تتحمل مسؤولية عن:
  تلف المنتج أثناء الشحن
  تضليل في وصف المنتج
  فشل البائع في التسليم
- يتحمل البائع المسؤولية الكاملة عن حل المشكلات مع المشتري.

11. سياسة الإرجاع والاسترداد:
- يجب على كل بائع تحديد سياسة إرجاع واضحة ضمن إدراجه أو متجره الخاص.
- إذا لم يحدد البائع سياسة، تُعتبر جميع المبيعات نهائية ولا يُسمح بالإرجاع أو الاسترداد إلا في حالات العيوب الجسيمة أو الاحتيال.

12. الإخفاق في تنفيذ الطلبات:
- إذا فشل البائع في تنفيذ الطلب بعد المزايدة الرابحة:
  1. يتم إصدار إنذار رسمي.
  2. يُخصم 10٪ من قيمة المزاد لتعويض المشتري.
  3. قد يؤدي التكرار إلى تجميد الحساب أو تعطيله نهائيًا.

13. التنبيه والتحذير:
- يجوز للبائعين التواصل مع المشترين خارج المنصة لأغراض التنسيق اللوجستي، لكن فلس توصي بشدة أن تتم جميع الاتصالات الأساسية عبر المنصة لضمان الشفافية والمساءلة.
- يُنصح البائعون بعدم إنهاء المعاملات أو قبول المدفوعات خارج المنصة لتجنب الاحتيال.

14. تعليق الحساب أو إنهاؤه:
يجوز لفلس تعليق أو تعطيل حساب البائع نهائيًا في الحالات التالية:
- مخالفة أي من الشروط الواردة هنا
- إدراج منتجات محظورة أو غير مناسبة
- تقديم معلومات كاذبة أو مضللة
- تلقي شكاوى مفرطة
- الانخراط في سلوك غير قانوني أو غير أخلاقي

15. حماية البيانات:
- تعتمد فلس تدابير معقولة لضمان أمان وسرية بيانات البائع، بما في ذلك معلومات الدفع والتواصل.
- لا يتم مشاركة بيانات البائع إلا عند الضرورة من أجل:
  إتمام الصفقات
  تنفيذ التوصيل
  الامتثال للالتزامات القانونية

16. القانون الحاكم والاختصاص القضائي:
- تخضع هذه الشروط وتُفسر وفقًا لقوانين دولة الكويت.
- أي نزاع ينشأ عن هذه الشروط يكون اختصاص المحاكم الكويتية حصريًا.

17. التعديلات والإشعارات:
- يجوز لفلس تعديل هذه الشروط من وقت لآخر، ويتم إرسال الإشعارات عبر البريد الإلكتروني المرتبط بحساب البائع.
- قد تستخدم فلس أيضًا الرسائل داخل التطبيق أو التذكيرات النظامية لإرسال التحديثات.
- استمرار استخدام المنصة بعد استلام الإشعار يُعد قبولًا للشروط المعدلة.
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  )
                      : getLang() == 'en'
                      ? const DefaultText(
                    '''
* Terms and Conditions (Sellers)

Effective Date: 01/01/2028
Last Updated: 06/26/2025

At Fils owned and operated by Fils Commission Agent and Trade by Commission Company ("We", "Our" or "Company"), we are honored to provide a platform where sellers can connect with buyers through transparent, well-regulated auctions and direct sales. These Terms of Service (“Terms”) outline the rights and responsibilities of sellers offering products via our platform (“Platform”). By registering as a seller, you agree to these Terms in full and confirm your understanding of the processes involved in listing, selling, and fulfilling your obligations as a seller on Fils. If you have any questions, please do not hesitate to contact us before proceeding.

Definitions:

- Platform: Refers to the application and website owned and managed by Fils Company, including all features, services, and tools associated with them.
- User: Any natural or legal person who creates an account on the platform, whether as a buyer, bidder, or seller, and is subject to these Terms of Service.
- Bidder: The user who participates in auctions by placing bids on products listed on the platform.
- Buyer: The user who purchases a product through auction or direct sale on the platform.
- Seller: The person or entity who offers their products for sale or auction on the platform, whether directly or through Fils as commission-based agents.
- Listing: Any offer or advertisement of a product published by the seller on the platform.
- Auction: A selling mechanism in which products are offered for a specified period of time, during which bids are submitted, and the highest bidder at the end of the period wins.
- Bid: The financial offer submitted by the bidder during the auction with the intention of purchasing the product.
- Winning Bidder: The user who submitted the highest bid at the end of the auction and was officially notified of the win.
- Direct Sale: A sale process that allows the buyer to purchase the product immediately at the specified price without entering an auction.
- Reserve Price: The minimum price set by the seller, which must be met or exceeded for the sale to be executed.
- Buy Now: An option provided by the seller to sell the product at a specified price without waiting for the auction to end.
- Product: Any physical or digital item offered for sale or auction on the platform.
- Escrow: A financial amount temporarily held by Fils to ensure the seriousness of the bidder, and is refunded in accordance with the stated terms.
- Fils Wallet: A balance within the application used to make payments on the platform.
- Available Balance: The financial value that the user can use in their wallet on the platform.
- Administrative Fees: Any amounts deducted by Fils in exchange for managing the auction, the platform, or processing certain transactions.
- Return Policy: A set of terms that define when and how the buyer may return the product and recover the paid amount.
- Dispute: Any disagreement between the user and Fils or between other users related to the product, service, or terms of use.
- Official Notice: Any message sent via email to the user’s address associated with their account on the platform.
- Governing Law: The laws in force in the State of Kuwait which apply to these Terms of Service and any dispute arising therefrom.
- Content: Refers to all information, text, images, or offers submitted or published by the user on the platform.

1. Eligibility to Sell on the Platform
1.1. The Platform is available to individuals and businesses legally operating within the State of Kuwait. Sellers must either be:
- A registered company or commercial establishment with a valid trade license in Kuwait; or
- An individual authorized to sell in a commercial capacity within the legal framework of Kuwaiti law (License holder: An agent or a sole proprietorship owner).
1.2. Sellers must possess the legal capacity to enter into binding agreements under applicable Kuwaiti laws.

2. Permissible and Restricted Products
2.1. Sellers may offer a wide range of products, provided the items are legally permitted under the laws of Kuwait and comply with public order, decency, and community standards.
2.2. Items that are internationally prohibited, restricted by Kuwaiti law, or considered culturally or legally sensitive may not be listed. Fils retains discretion to determine whether a listing is inappropriate or in violation of this section and may remove such listings without prior notice.

3. Product Listing Requirements
3.1. Each product listing must include a clear and complete description. This includes, but is not limited to:
- Product dimensions, weight, color, and condition (new/used)
- Country of manufacture
- Any known defects, limitations, or missing components
3.2. Sellers are required to upload clear images of the actual product offered for sale. Use of inaccurate, misleading, or stock images without context is strictly prohibited.

4. Pricing Options
4.1. Reserve Price (Minimum Acceptable Price): Sellers may define a minimum price below which they will not accept a sale. If bidding does not reach this reserve price, the transaction will be automatically void and the listing will expire.
4.2. Buy Now Price: Sellers who operate a virtual store on the Platform may set a “Buy Now” price, enabling customers to bypass the auction process and purchase the item directly. Sellers without an active store may only use a fixed-price option if they list the item using the direct sale category specifically designated for non-auction transactions.

5. Modifications and Cancellations
5.1. Once a bid is placed, the listing is considered active and cannot be edited or removed by the seller.
5.2. Prior to receiving any bids, the seller may cancel the listing through their dashboard, provided no offers have been submitted.
5.3. Listings that do not receive bids or fail to reach the reserve price will automatically expire and be removed from the Platform.

6. Fees and Commission
6.1. Fils applies a commission fee (a percentage or a fixed amount) as stated in the fee structure on each completed sale, and this fee is deducted from the final amount due to the seller. The exact fee structure is made available in your seller dashboard. Sellers are expected to review these fees carefully and must cancel their account or stop listing items if they do not agree to the terms.
6.2. Fils may revise the fee structure from time to time. Such changes will only apply prospectively to new listings created after the change.

7. Payment to Sellers
7.1. Sellers will receive payment within twenty-one (21) business days following successful delivery of the item to the buyer and confirmation of its condition.
7.2. In the event the buyer does not confirm receipt within the prescribed period, Fils will investigate the delivery status and, at its sole discretion, may proceed with releasing the payment.

8. Shipping and Delivery
8.1. Sellers are responsible for choosing the delivery method. They may:
- Use one of Fils' integrated delivery partners; or
- Handle the delivery themselves or through their own provider
8.2. The seller bears full responsibility for:
- Timely dispatch
- Safe packaging
- Providing tracking details (where applicable)

9. Disputes and Responsibility
9.1. Fils operates strictly as a technology platform to facilitate listings and payments. Fils does not assume responsibility for:
- Product damage during shipment
- Product misrepresentation
- Failure to deliver by the seller
9.2. The seller and their chosen delivery provider are solely liable for resolving such issues with the buyer. Fils may provide limited support in facilitating communication, but is not a party to the transaction.

10. Return and Refund Policy
10.1. Each seller is required to clearly state their return and refund policy on the listing or storefront. Fils does not impose a uniform return policy.
10.2. If a seller does not specify a policy, all sales shall be considered final, and no returns or refunds shall be granted except in cases of fraud or major undisclosed defects.

11. Failure to Fulfill Orders
11.1. If a seller fails to fulfill an order after a winning bid, the following consequences apply:
First:
1. A formal warning will be issued
2. The seller must compensate the buyer with 10% of the auction value, which will be deducted from their account balance or future earnings
Second:
11.2. Repeated failures may lead to account suspension.
Third:
11.3. In case of recurrence, this shall result in permanent account deactivation.

12. Caution and Warning
12.1. While sellers may communicate with buyers outside the Platform for logistical coordination, Fils strongly recommends that all key communications and confirmations occur through the Platform for transparency and accountability.
12.2. To prevent fraud and protect both parties, sellers are advised not to finalize transactions or accept payments outside the Platform. Doing so may result in loss of protection and potential account penalties.

13. Account Suspension or Termination
13.1. Fils may suspend or permanently deactivate a seller’s account in the event of:
- Violation of any term outlined herein
- Listing of prohibited or inappropriate products
- Submitting false or misleading information
- Receiving excessive complaints
- Engaging in unethical or unlawful conduct
13.2. Sellers have the right to appeal any disciplinary action by contacting Fils support and providing relevant evidence.

14. Data Protection
14.1. Fils implements reasonable safeguards to ensure the security and confidentiality of seller data, including payment and contact information.
14.2. Seller data will not be sold or shared except where necessary to:
- Complete transactions
- Fulfill delivery
- Comply with legal obligations

15. Governing Law and Jurisdiction
15.1. These Terms are governed by and shall be construed in accordance with the laws of the State of Kuwait.
15.2. Any dispute arising from these Terms shall be subject to the exclusive jurisdiction of the competent courts in Kuwait.

16. Amendments and Notices
16.1. Fils may amend these Terms from time to time. Official notifications, including changes to the Terms, will be sent by email to the address associated with the seller's account.
16.2. For general updates, system notifications, or reminders, Fils may also use in-app messages, WhatsApp, or other informal means.
16.3. Continued use of the Platform following receipt of such notice shall constitute acceptance of the revised Terms.
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  )
                      : getLang() == 'in'
                      ? const DefaultText(
                    '''
* नियम और शर्तें (विक्रेता)

प्रभावी तिथि: 01/01/2028
अंतिम अद्यतन: 06/26/2025

फ़िल्स कमीशन एजेंट और ट्रेड बाय कमीशन कंपनी ("हम", "हमारा" या "कंपनी") के स्वामित्व और संचालन वाले फ़िल्स में, हमें एक ऐसा प्लेटफ़ॉर्म प्रदान करने पर गर्व है जहाँ विक्रेता पारदर्शी, सुव्यवस्थित नीलामी और प्रत्यक्ष बिक्री के माध्यम से खरीदारों से जुड़ सकते हैं। ये सेवा की शर्तें ("शर्तें") हमारे प्लेटफ़ॉर्म ("प्लेटफ़ॉर्म") के माध्यम से उत्पाद बेचने वाले विक्रेताओं के अधिकारों और ज़िम्मेदारियों को रेखांकित करती हैं। विक्रेता के रूप में पंजीकरण करके, आप इन शर्तों से पूरी तरह सहमत होते हैं और फ़िल्स पर एक विक्रेता के रूप में लिस्टिंग, बिक्री और अपने दायित्वों को पूरा करने में शामिल प्रक्रियाओं की अपनी समझ की पुष्टि करते हैं। यदि आपके कोई प्रश्न हैं, तो कृपया आगे बढ़ने से पहले हमसे संपर्क करने में संकोच न करें।

परिभाषाएँ:

- प्लेटफ़ॉर्म: फ़िल कंपनी के स्वामित्व और प्रबंधन वाले एप्लिकेशन और वेबसाइट को संदर्भित करता है, जिसमें उनसे जुड़ी सभी सुविधाएँ, सेवाएँ और उपकरण शामिल हैं।
- उपयोगकर्ता: कोई भी प्राकृतिक या कानूनी व्यक्ति जो प्लेटफ़ॉर्म पर खाता बनाता है, चाहे वह खरीदार, बोलीदाता या विक्रेता के रूप में हो, और इन सेवा की शर्तों के अधीन हो।
- बोलीदाता: वह उपयोगकर्ता जो प्लेटफ़ॉर्म पर सूचीबद्ध उत्पादों पर बोली लगाकर नीलामी में भाग लेता है।
- खरीदार: वह उपयोगकर्ता जो प्लेटफ़ॉर्म पर नीलामी या प्रत्यक्ष बिक्री के माध्यम से कोई उत्पाद खरीदता है।
- विक्रेता: वह व्यक्ति या संस्था जो प्लेटफ़ॉर्म पर अपने उत्पादों को बिक्री या नीलामी के लिए प्रस्तुत करता है, चाहे सीधे या कमीशन-आधारित एजेंट के रूप में Fils के माध्यम से।
- लिस्टिंग: प्लेटफ़ॉर्म पर विक्रेता द्वारा प्रकाशित किसी उत्पाद का कोई प्रस्ताव या विज्ञापन।
- नीलामी: एक विक्रय प्रणाली जिसमें उत्पादों को एक निर्दिष्ट अवधि के लिए पेश किया जाता है, जिसके दौरान बोलियाँ प्रस्तुत की जाती हैं, और अवधि के अंत में सबसे ऊँची बोली लगाने वाला विजेता होता है।
- बोली: उत्पाद खरीदने के इरादे से नीलामी के दौरान बोली लगाने वाले द्वारा प्रस्तुत वित्तीय प्रस्ताव।
- विजेता बोलीदाता: वह उपयोगकर्ता जिसने नीलामी के अंत में सबसे ऊँची बोली प्रस्तुत की और जिसे आधिकारिक तौर पर जीत की सूचना दी गई।
- प्रत्यक्ष बिक्री: एक बिक्री प्रक्रिया जो खरीदार को नीलामी में भाग लिए बिना, निर्दिष्ट मूल्य पर तुरंत उत्पाद खरीदने की अनुमति देती है।
- आरक्षित मूल्य: विक्रेता द्वारा निर्धारित न्यूनतम मूल्य, जिसे बिक्री के लिए पूरा किया जाना या उससे अधिक होना आवश्यक है।
- अभी खरीदें: नीलामी समाप्त होने की प्रतीक्षा किए बिना, विक्रेता द्वारा उत्पाद को निर्दिष्ट मूल्य पर बेचने का विकल्प।
- उत्पाद: प्लेटफ़ॉर्म पर बिक्री या नीलामी के लिए प्रस्तुत कोई भी भौतिक या डिजिटल वस्तु।
- एस्क्रो: बोली लगाने वाले की गंभीरता सुनिश्चित करने के लिए Fils द्वारा अस्थायी रूप से रखी गई एक वित्तीय राशि, और बताई गई शर्तों के अनुसार वापस कर दी जाती है।
- Fils वॉलेट: प्लेटफ़ॉर्म पर भुगतान करने के लिए उपयोग की जाने वाली एप्लिकेशन के भीतर शेष राशि।
- उपलब्ध शेष राशि: वह वित्तीय मूल्य जिसका उपयोग उपयोगकर्ता प्लेटफ़ॉर्म पर अपने वॉलेट में कर सकता है।
- प्रशासनिक शुल्क: नीलामी, प्लेटफ़ॉर्म के प्रबंधन या कुछ लेनदेन को संसाधित करने के बदले में Fils द्वारा काटी गई कोई भी राशि।
- वापसी नीति: शर्तों का एक समूह जो यह निर्धारित करता है कि खरीदार कब और कैसे उत्पाद वापस कर सकता है और भुगतान की गई राशि वापस प्राप्त कर सकता है।
- विवाद: उपयोगकर्ता और Fils के बीच या अन्य उपयोगकर्ताओं के बीच उत्पाद, सेवा या उपयोग की शर्तों से संबंधित कोई भी असहमति।
- आधिकारिक सूचना: प्लेटफ़ॉर्म पर उपयोगकर्ता के खाते से जुड़े पते पर ईमेल द्वारा भेजा गया कोई भी संदेश।
- शासकीय कानून: कुवैत राज्य में लागू कानून जो इन सेवा की शर्तों और उनसे उत्पन्न होने वाले किसी भी विवाद पर लागू होते हैं।
- विषय-वस्तु: प्लेटफ़ॉर्म पर उपयोगकर्ता द्वारा सबमिट या प्रकाशित सभी जानकारी, पाठ, चित्र या ऑफ़र को संदर्भित करता है।

1. प्लेटफ़ॉर्म पर बेचने की पात्रता
1.1. यह प्लेटफ़ॉर्म कुवैत राज्य में कानूनी रूप से संचालित व्यक्तियों और व्यवसायों के लिए उपलब्ध है। विक्रेताओं को या तो यह होना चाहिए:
- कुवैत में वैध व्यापार लाइसेंस वाली एक पंजीकृत कंपनी या व्यावसायिक प्रतिष्ठान; या
- कुवैती कानून के कानूनी ढांचे के भीतर व्यावसायिक क्षमता में बिक्री करने के लिए अधिकृत व्यक्ति (लाइसेंस धारक: एक एजेंट या एकमात्र स्वामित्व वाला स्वामी)।
1.2. विक्रेताओं के पास लागू कुवैती कानूनों के तहत बाध्यकारी समझौते करने की कानूनी क्षमता होनी चाहिए।

2. अनुमत और प्रतिबंधित उत्पाद
2.1. विक्रेता उत्पादों की एक विस्तृत श्रृंखला पेश कर सकते हैं, बशर्ते कि वे कुवैत के कानूनों के तहत कानूनी रूप से अनुमत हों और सार्वजनिक व्यवस्था, शालीनता और सामुदायिक मानकों का पालन करते हों।
2.2. वे उत्पाद जो अंतरराष्ट्रीय स्तर पर प्रतिबंधित हैं, कुवैती कानून द्वारा प्रतिबंधित हैं, या सांस्कृतिक या कानूनी रूप से संवेदनशील माने जाते हैं, उन्हें सूचीबद्ध नहीं किया जा सकता है। Fils यह निर्धारित करने का विवेकाधिकार रखता है कि कोई सूची अनुपयुक्त है या इस खंड का उल्लंघन करती है और बिना किसी पूर्व सूचना के ऐसी सूची को हटा सकता है।

3. उत्पाद सूचीकरण आवश्यकताएँ
3.1. प्रत्येक उत्पाद सूचीकरण में एक स्पष्ट और पूर्ण विवरण शामिल होना चाहिए। इसमें निम्नलिखित शामिल हैं, लेकिन इन्हीं तक सीमित नहीं हैं:
- उत्पाद के आयाम, वज़न, रंग और स्थिति (नया/प्रयुक्त)
- निर्माण का देश
- कोई भी ज्ञात दोष, सीमाएँ, या गायब घटक
3.2. विक्रेताओं को बिक्री के लिए प्रस्तुत वास्तविक उत्पाद की स्पष्ट छवियाँ अपलोड करनी होंगी। गलत, भ्रामक, या बिना संदर्भ वाली स्टॉक छवियों का उपयोग सख्त वर्जित है।

4. मूल्य निर्धारण विकल्प
4.1. आरक्षित मूल्य (न्यूनतम स्वीकार्य मूल्य): विक्रेता एक न्यूनतम मूल्य निर्धारित कर सकते हैं जिसके नीचे वे बिक्री स्वीकार नहीं करेंगे। यदि बोली इस आरक्षित मूल्य तक नहीं पहुँचती है, तो लेनदेन स्वतः ही रद्द हो जाएगा और सूचीकरण समाप्त हो जाएगा।
4.2. अभी खरीदें मूल्य: प्लेटफ़ॉर्म पर वर्चुअल स्टोर संचालित करने वाले विक्रेता "अभी खरीदें" मूल्य निर्धारित कर सकते हैं, जिससे ग्राहक नीलामी प्रक्रिया को दरकिनार करके सीधे वस्तु खरीद सकते हैं। जिन विक्रेताओं का कोई सक्रिय स्टोर नहीं है, वे केवल तभी निश्चित-मूल्य विकल्प का उपयोग कर सकते हैं जब वे गैर-नीलामी लेनदेन के लिए विशेष रूप से निर्दिष्ट प्रत्यक्ष बिक्री श्रेणी का उपयोग करके वस्तु सूचीबद्ध करते हैं।

5. संशोधन और रद्दीकरण
5.1. बोली लगने के बाद, लिस्टिंग को सक्रिय माना जाता है और विक्रेता द्वारा इसे संपादित या हटाया नहीं जा सकता।
5.2. कोई भी बोली प्राप्त होने से पहले, विक्रेता अपने डैशबोर्ड के माध्यम से लिस्टिंग को रद्द कर सकता है, बशर्ते कोई प्रस्ताव प्रस्तुत न किया गया हो।
5.3. जिन लिस्टिंग पर बोलियाँ नहीं आतीं या जो आरक्षित मूल्य तक नहीं पहुँच पातीं, वे स्वतः ही समाप्त हो जाएँगी और प्लेटफ़ॉर्म से हटा दी जाएँगी।

6. शुल्क और कमीशन
6.1. Fils प्रत्येक पूर्ण बिक्री पर शुल्क संरचना में बताए अनुसार एक कमीशन शुल्क (एक प्रतिशत या एक निश्चित राशि) लगाता है, और यह शुल्क विक्रेता को देय अंतिम राशि से काट लिया जाता है। सटीक शुल्क संरचना आपके विक्रेता डैशबोर्ड में उपलब्ध कराई गई है। विक्रेताओं से अपेक्षा की जाती है कि वे इन शुल्कों की सावधानीपूर्वक समीक्षा करें और यदि वे शर्तों से सहमत नहीं हैं, तो उन्हें अपना खाता रद्द करना होगा या आइटम सूचीबद्ध करना बंद करना होगा।
6.2. Fils समय-समय पर शुल्क संरचना में संशोधन कर सकता है। ऐसे परिवर्तन केवल परिवर्तन के बाद बनाई गई नई लिस्टिंग पर ही लागू होंगे।

7. विक्रेताओं को भुगतान
7.1. विक्रेता को खरीदार को वस्तु की सफल डिलीवरी और उसकी स्थिति की पुष्टि के बाद इक्कीस (21) व्यावसायिक दिनों के भीतर भुगतान प्राप्त होगा।
7.2. यदि खरीदार निर्धारित अवधि के भीतर रसीद की पुष्टि नहीं करता है, तो Fils डिलीवरी की स्थिति की जाँच करेगा और अपने विवेकानुसार भुगतान जारी कर सकता है।

8. शिपिंग और डिलीवरी
8.1. डिलीवरी विधि चुनने की ज़िम्मेदारी विक्रेताओं की है। वे:
- Fils के एकीकृत डिलीवरी भागीदारों में से किसी एक का उपयोग कर सकते हैं; या
- डिलीवरी स्वयं या अपने प्रदाता के माध्यम से कर सकते हैं।
8.2. विक्रेता की पूरी ज़िम्मेदारी है:
- समय पर प्रेषण
- सुरक्षित पैकेजिंग
- ट्रैकिंग विवरण प्रदान करना (जहाँ लागू हो)
9. विवाद और ज़िम्मेदारी
9.1. Fils लिस्टिंग और भुगतान की सुविधा के लिए एक तकनीकी प्लेटफ़ॉर्म के रूप में पूरी तरह से काम करता है। Fils निम्नलिखित के लिए ज़िम्मेदारी नहीं लेता:
- शिपमेंट के दौरान उत्पाद को नुकसान
- उत्पाद की गलत जानकारी
- विक्रेता द्वारा डिलीवरी न करना
9.2. विक्रेता और उनके द्वारा चुना गया डिलीवरी प्रदाता खरीदार के साथ ऐसे मुद्दों को सुलझाने के लिए पूरी तरह से ज़िम्मेदार हैं। Fils संचार को सुगम बनाने में सीमित सहायता प्रदान कर सकता है, लेकिन लेन-देन में पक्ष नहीं है।

10. वापसी और धनवापसी नीति
10.1. प्रत्येक विक्रेता को लिस्टिंग या स्टोरफ्रंट पर अपनी वापसी और धनवापसी नीति स्पष्ट रूप से बतानी होगी। Fils एक समान वापसी नीति लागू नहीं करता है।
10.2. यदि कोई विक्रेता कोई नीति निर्दिष्ट नहीं करता है, तो सभी बिक्री अंतिम मानी जाएगी, और धोखाधड़ी या प्रमुख अघोषित दोषों के मामलों को छोड़कर कोई वापसी या धनवापसी नहीं दी जाएगी।

11. ऑर्डर पूरा न करना
11.1. यदि कोई विक्रेता विजयी बोली के बाद ऑर्डर पूरा करने में विफल रहता है, तो निम्नलिखित परिणाम लागू होंगे:
पहला:
1. एक औपचारिक चेतावनी जारी की जाएगी
2. विक्रेता को खरीदार को नीलामी मूल्य का 10% मुआवजा देना होगा, जो उनके खाते की शेष राशि या भविष्य की आय से काट लिया जाएगा
दूसरा:
11.2. बार-बार विफलताओं के कारण खाता निलंबित हो सकता है।
तीसरा:
11.3. पुनरावृत्ति की स्थिति में, इसके परिणामस्वरूप खाता स्थायी रूप से निष्क्रिय हो जाएगा।

12. सावधानी और चेतावनी
12.1. यद्यपि विक्रेता लॉजिस्टिक्स समन्वय के लिए प्लेटफ़ॉर्म के बाहर खरीदारों के साथ संवाद कर सकते हैं, Fils दृढ़ता से अनुशंसा करता है कि पारदर्शिता और जवाबदेही के लिए सभी महत्वपूर्ण संचार और पुष्टिकरण प्लेटफ़ॉर्म के माध्यम से हों।
12.2. धोखाधड़ी को रोकने और दोनों पक्षों की सुरक्षा के लिए, विक्रेताओं को सलाह दी जाती है कि वे प्लेटफ़ॉर्म के बाहर लेनदेन को अंतिम रूप न दें या भुगतान स्वीकार न करें। ऐसा करने से सुरक्षा समाप्त हो सकती है और खाता दंड लग सकता है।

13. खाता निलंबन या समाप्ति
13.1. Fils निम्नलिखित स्थितियों में विक्रेता के खाते को निलंबित या स्थायी रूप से निष्क्रिय कर सकता है:
- यहाँ उल्लिखित किसी भी नियम का उल्लंघन
- निषिद्ध या अनुपयुक्त उत्पादों की सूची
- झूठी या भ्रामक जानकारी प्रस्तुत करना
- अत्यधिक शिकायतें प्राप्त करना
- अनैतिक या गैरकानूनी आचरण में संलिप्त होना
13.2. विक्रेताओं को Fils सहायता से संपर्क करके और प्रासंगिक साक्ष्य प्रदान करके किसी भी अनुशासनात्मक कार्रवाई के विरुद्ध अपील करने का अधिकार है।

14. डेटा सुरक्षा
14.1. Fils भुगतान और संपर्क जानकारी सहित विक्रेता डेटा की सुरक्षा और गोपनीयता सुनिश्चित करने के लिए उचित सुरक्षा उपाय लागू करता है।
14.2. विक्रेता डेटा को बेचा या साझा नहीं किया जाएगा, सिवाय इसके कि निम्नलिखित के लिए आवश्यक हो:
- लेनदेन पूरा करना
- डिलीवरी पूरी करना
- कानूनी दायित्वों का पालन करना

15. शासन कानून और क्षेत्राधिकार
15.1. ये नियम कुवैत राज्य के कानूनों द्वारा शासित और उनके अनुसार व्याख्या किए जाएँगे।
15.2. इन शर्तों से उत्पन्न होने वाला कोई भी विवाद कुवैत के सक्षम न्यायालयों के अनन्य क्षेत्राधिकार के अधीन होगा।

16. संशोधन और सूचनाएँ
16.1. Fils समय-समय पर इन शर्तों में संशोधन कर सकता है। शर्तों में बदलावों सहित आधिकारिक सूचनाएँ विक्रेता के खाते से जुड़े पते पर ईमेल द्वारा भेजी जाएँगी।
16.2. सामान्य अपडेट, सिस्टम सूचनाएँ या रिमाइंडर के लिए, Fils इन-ऐप संदेशों, व्हाट्सएप या अन्य अनौपचारिक माध्यमों का भी उपयोग कर सकता है।
16.3. ऐसी सूचना प्राप्त होने के बाद प्लेटफ़ॉर्म का निरंतर उपयोग संशोधित शर्तों की स्वीकृति माना जाएगा।
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  )
                      : getLang() == 'ir'
                      ? const DefaultText(
                    '''
* شرایط و ضوابط (فروشندگان)

تاریخ اجرا: 01/01/2028
آخرین به‌روزرسانی: 06/26/2025

در Fils که متعلق به و تحت مدیریت Fils Commission Agent و Trade by Commission Company ("ما"، "شرکت ما" یا "شرکت") است، مفتخریم که بستری را فراهم کنیم که فروشندگان بتوانند از طریق حراج‌های شفاف و منظم و فروش مستقیم با خریداران ارتباط برقرار کنند. این شرایط خدمات ("شرایط") حقوق و مسئولیت‌های فروشندگانی را که محصولات را از طریق پلتفرم ما ("پلتفرم") ارائه می‌دهند، تشریح می‌کند. با ثبت نام به عنوان فروشنده، شما با این شرایط به طور کامل موافقت می‌کنید و درک خود را از فرآیندهای مربوط به فهرست‌بندی، فروش و انجام تعهدات خود به عنوان فروشنده در Fils تأیید می‌کنید. در صورت داشتن هرگونه سؤال، لطفاً قبل از ادامه با ما تماس بگیرید.

تعاریف:

- پلتفرم: به برنامه و وب‌سایتی که متعلق به و تحت مدیریت شرکت Fils است، شامل تمام ویژگی‌ها، خدمات و ابزارهای مرتبط با آنها اشاره دارد.

- کاربر: هر شخص حقیقی یا حقوقی که در پلتفرم، چه به عنوان خریدار، پیشنهاد دهنده یا فروشنده، حساب کاربری ایجاد می‌کند و مشمول این شرایط خدمات است.

- پیشنهاد دهنده: کاربری که با ارائه پیشنهاد برای محصولات فهرست شده در پلتفرم، در مزایده‌ها شرکت می‌کند.

- خریدار: کاربری که محصولی را از طریق مزایده یا فروش مستقیم در پلتفرم خریداری می‌کند.

- فروشنده: شخص یا نهادی که محصولات خود را برای فروش یا مزایده در پلتفرم ارائه می‌دهد، چه به طور مستقیم و چه از طریق فیلز به عنوان نمایندگان مبتنی بر پورسانت.

- فهرست: هرگونه پیشنهاد یا تبلیغ محصول که توسط فروشنده در پلتفرم منتشر می‌شود.

- حراج: مکانیسم فروشی که در آن محصولات برای مدت زمان مشخصی ارائه می‌شوند و در طی آن پیشنهادات ارائه می‌شوند و بالاترین پیشنهاد دهنده در پایان دوره برنده می‌شود.

- پیشنهاد: پیشنهاد مالی که توسط پیشنهاد دهنده در طول حراج با هدف خرید محصول ارائه می‌شود.

- پیشنهاد دهنده برنده: کاربری که بالاترین پیشنهاد را در پایان حراج ارائه داده و رسماً از برنده شدن مطلع شده است.

- فروش مستقیم: فرآیند فروشی که به خریدار اجازه می‌دهد محصول را بلافاصله با قیمت مشخص شده و بدون ورود به حراج خریداری کند.

- قیمت رزرو: حداقل قیمت تعیین شده توسط فروشنده که برای انجام فروش باید به آن برسد یا از آن فراتر رود.

- همین حالا بخرید: گزینه‌ای که توسط فروشنده برای فروش محصول با قیمت مشخص و بدون انتظار برای پایان حراج ارائه می‌شود.

- محصول: هر کالای فیزیکی یا دیجیتالی که برای فروش یا حراج در پلتفرم ارائه می‌شود.

- سپرده: مبلغ مالی که به طور موقت توسط فیلز برای اطمینان از جدیت پیشنهاد دهنده نگهداری می‌شود و مطابق با شرایط اعلام شده بازپرداخت می‌شود.

- کیف پول فیلز: موجودی در برنامه‌ای که برای انجام پرداخت‌ها در پلتفرم استفاده می‌شود.

- موجودی موجود: ارزش مالی که کاربر می‌تواند از کیف پول خود در پلتفرم استفاده کند.

- هزینه‌های اداری: هر مبلغی که توسط فیلز در ازای مدیریت حراج، پلتفرم یا پردازش تراکنش‌های خاص کسر می‌شود.

- سیاست بازگشت: مجموعه‌ای از شرایط که زمان و نحوه بازگشت محصول و بازیابی مبلغ پرداختی توسط خریدار را تعریف می‌کند. - اختلاف: هرگونه اختلاف نظر بین کاربر و فیلز یا بین سایر کاربران مربوط به محصول، خدمات یا شرایط استفاده.

- اطلاعیه رسمی: هر پیامی که از طریق ایمیل به آدرس کاربر مرتبط با حساب کاربری او در پلتفرم ارسال شود.

- قانون حاکم: قوانین جاری در کشور کویت که در مورد این شرایط خدمات و هرگونه اختلاف ناشی از آن اعمال می‌شود.

- محتوا: به تمام اطلاعات، متن، تصاویر یا پیشنهادات ارسالی یا منتشر شده توسط کاربر در پلتفرم اشاره دارد.


1. واجد شرایط بودن برای فروش در پلتفرم

1.1. این پلتفرم برای افراد و مشاغلی که به طور قانونی در کشور کویت فعالیت می‌کنند، در دسترس است. فروشندگان باید یا:
- یک شرکت یا موسسه تجاری ثبت شده با مجوز تجاری معتبر در کویت باشند؛ یا
- فردی که مجاز به فروش در یک ظرفیت تجاری در چارچوب قانونی قانون کویت باشد (دارنده مجوز: نماینده یا مالک انحصاری).


1.2. فروشندگان باید از نظر قانونی صلاحیت انعقاد قراردادهای الزام‌آور تحت قوانین قابل اجرا در کویت را داشته باشند.


۲. محصولات مجاز و محدود
۲.۱. فروشندگان می‌توانند طیف گسترده‌ای از محصولات را ارائه دهند، مشروط بر اینکه اقلام طبق قوانین کویت مجاز باشند و با نظم عمومی، عفت و استانداردهای جامعه مطابقت داشته باشند.

۲.۲. اقلامی که از نظر بین‌المللی ممنوع، محدود شده توسط قانون کویت یا از نظر فرهنگی یا قانونی حساس تلقی می‌شوند، ممکن است در فهرست قرار نگیرند. فیلز اختیار دارد تا تعیین کند که آیا یک فهرست نامناسب یا ناقض این بخش است یا خیر و ممکن است چنین فهرست‌هایی را بدون اطلاع قبلی حذف کند.

۳. الزامات فهرست‌بندی محصول
۳.۱. هر فهرست محصول باید شامل توضیحات واضح و کاملی باشد. این شامل موارد زیر می‌شود، اما محدود به آنها نیست:
- ابعاد محصول، وزن، رنگ و وضعیت (نو/دست دوم)
- کشور سازنده
- هرگونه نقص، محدودیت یا اجزای مفقود شناخته شده
۳.۲. فروشندگان موظفند تصاویر واضحی از محصول واقعی ارائه شده برای فروش آپلود کنند. استفاده از تصاویر نادرست، گمراه‌کننده یا موجود بدون زمینه اکیداً ممنوع است.
۴. گزینه‌های قیمت‌گذاری
۴.۱. قیمت رزرو (حداقل قیمت قابل قبول): فروشندگان می‌توانند حداقل قیمتی را تعیین کنند که فروش کمتر از آن را نپذیرند. اگر پیشنهاد قیمت به این قیمت رزرو نرسد، معامله به طور خودکار باطل و فهرست منقضی می‌شود.

۴.۲. قیمت همین حالا بخرید: فروشندگانی که فروشگاه مجازی در پلتفرم دارند، می‌توانند قیمت «همین حالا بخرید» را تعیین کنند که به مشتریان امکان می‌دهد فرآیند حراج را دور بزنند و کالا را مستقیماً خریداری کنند. فروشندگانی که فروشگاه فعال ندارند، فقط در صورتی می‌توانند از گزینه قیمت ثابت استفاده کنند که کالا را با استفاده از دسته فروش مستقیم که به طور خاص برای معاملات غیرحراجی تعیین شده است، فهرست کنند.

۵. اصلاحات و لغوها
۵.۱. پس از ثبت پیشنهاد، فهرست فعال تلقی می‌شود و فروشنده نمی‌تواند آن را ویرایش یا حذف کند.

۵.۲. قبل از دریافت هرگونه پیشنهاد، فروشنده می‌تواند فهرست را از طریق داشبورد خود لغو کند، مشروط بر اینکه هیچ پیشنهادی ارائه نشده باشد.

۵.۳. فهرست‌هایی که پیشنهاد دریافت نمی‌کنند یا به قیمت رزرو نمی‌رسند، به طور خودکار منقضی و از پلتفرم حذف می‌شوند.

6. هزینه‌ها و پورسانت
6.1. فیلز برای هر فروش تکمیل‌شده، پورسانت (درصد یا مبلغ ثابت) را طبق ساختار پورسانت اعمال می‌کند و این هزینه از مبلغ نهایی قابل پرداخت به فروشنده کسر می‌شود. ساختار دقیق پورسانت در داشبورد فروشنده شما موجود است. از فروشندگان انتظار می‌رود این هزینه‌ها را با دقت بررسی کنند و در صورت عدم موافقت با شرایط، باید حساب خود را لغو کنند یا فهرست اقلام را متوقف کنند.

6.2. فیلز ممکن است هر از گاهی ساختار پورسانت را اصلاح کند. چنین تغییراتی فقط به صورت آینده‌نگر برای فهرست‌های جدیدی که پس از تغییر ایجاد می‌شوند، اعمال خواهد شد.

7. پرداخت به فروشندگان
7.1. فروشندگان ظرف بیست و یک (21) روز کاری پس از تحویل موفقیت‌آمیز کالا به خریدار و تأیید وضعیت آن، وجه را دریافت خواهند کرد.

7.2. در صورتی که خریدار در مدت زمان مقرر، دریافت را تأیید نکند، فیلز وضعیت تحویل را بررسی کرده و به صلاحدید خود، می‌تواند نسبت به آزادسازی وجه اقدام کند.

8. ارسال و تحویل
8.1. فروشندگان مسئول انتخاب روش تحویل هستند. آنها می‌توانند:
- از یکی از شرکای تحویل یکپارچه فیلز استفاده کنند؛ یا
- خودشان یا از طریق ارائه‌دهنده خودشان تحویل را انجام دهند.

8.2. فروشنده مسئولیت کامل موارد زیر را بر عهده دارد:
- ارسال به موقع
- بسته‌بندی ایمن
- ارائه جزئیات ردیابی (در صورت وجود)

9. اختلافات و مسئولیت

9.1. فیلز صرفاً به عنوان یک پلتفرم فناوری برای تسهیل فهرست‌بندی و پرداخت‌ها فعالیت می‌کند. فیلز مسئولیتی در قبال موارد زیر بر عهده نمی‌گیرد:
- آسیب محصول در حین حمل و نقل
- ارائه نادرست محصول
- عدم تحویل توسط فروشنده

9.2. فروشنده و ارائه‌دهنده تحویل منتخب او صرفاً مسئول حل چنین مسائلی با خریدار هستند. فیلز ممکن است پشتیبانی محدودی در تسهیل ارتباط ارائه دهد، اما طرف معامله نیست.

10. سیاست بازگشت و بازپرداخت

10.1. هر فروشنده موظف است سیاست بازگشت و بازپرداخت خود را به وضوح در فهرست‌بندی یا ویترین فروشگاه بیان کند. فیلز سیاست بازگشت یکسانی را اعمال نمی‌کند.

10.2. اگر فروشنده‌ای سیاستی را مشخص نکند، تمام فروش‌ها قطعی تلقی می‌شوند و هیچ گونه بازگشت یا بازپرداختی به جز در موارد کلاهبرداری یا نقص‌های عمده‌ی افشا نشده، پذیرفته نمی‌شود.


۱۱. عدم انجام سفارشات

۱۱.۱. اگر فروشنده‌ای پس از برنده شدن در مناقصه، سفارشی را انجام ندهد، عواقب زیر اعمال می‌شود:

اول:

۱. اخطار رسمی صادر خواهد شد

۲. فروشنده باید ۱۰٪ از ارزش حراج را به خریدار جبران کند که از موجودی حساب یا درآمدهای آینده‌ی او کسر می‌شود.

دوم:

۱۱.۲. عدم موفقیت‌های مکرر ممکن است منجر به تعلیق حساب شود.

سوم:

۱۱.۳. در صورت تکرار، این امر منجر به غیرفعال شدن دائمی حساب خواهد شد.


۱۲. هشدار و احتیاط

۱۲.۱. در حالی که فروشندگان ممکن است برای هماهنگی‌های لجستیکی با خریداران خارج از پلتفرم ارتباط برقرار کنند، فیلز اکیداً توصیه می‌کند که تمام ارتباطات و تأییدیه‌های کلیدی از طریق پلتفرم برای شفافیت و پاسخگویی انجام شود.

۱۲.۲. برای جلوگیری از کلاهبرداری و محافظت از هر دو طرف، به فروشندگان توصیه می‌شود که تراکنش‌ها را نهایی نکنند یا پرداخت‌ها را خارج از پلتفرم نپذیرند. انجام این کار ممکن است منجر به از دست دادن حفاظت و جریمه‌های احتمالی حساب شود.


۱۳. تعلیق یا فسخ حساب


۱۳.۱. فیلز می‌تواند در صورت موارد زیر، حساب فروشنده را به حالت تعلیق درآورد یا به طور دائم غیرفعال کند:

- نقض هر یک از شرایط ذکر شده در اینجا
- فهرست محصولات ممنوعه یا نامناسب
- ارسال اطلاعات نادرست یا گمراه‌کننده
- دریافت شکایات بیش از حد
- انجام رفتارهای غیراخلاقی یا غیرقانونی


۱۳.۲. فروشندگان حق دارند با تماس با پشتیبانی فیلز و ارائه شواهد مربوطه، نسبت به هرگونه اقدام انضباطی اعتراض کنند.


۱۴. حفاظت از داده‌ها


۱۴.۱. فیلز اقدامات حفاظتی معقولی را برای اطمینان از امنیت و محرمانه بودن داده‌های فروشنده، از جمله اطلاعات پرداخت و تماس، اجرا می‌کند.


۱۴.۲. داده‌های فروشنده فروخته یا به اشتراک گذاشته نمی‌شود، مگر در مواردی که برای موارد زیر ضروری باشد:

- تکمیل تراکنش‌ها
- انجام تحویل
- رعایت تعهدات قانونی

۱۵. قانون حاکم و صلاحیت قضایی
۱۵.۱. این شرایط تابع قوانین کشور کویت است و مطابق با آنها تفسیر خواهد شد.

۱۵.۲. هرگونه اختلاف ناشی از این شرایط، تابع صلاحیت انحصاری دادگاه‌های صالح کویت خواهد بود.

۱۶. اصلاحات و اطلاعیه‌ها
۱۶.۱. فیلز ممکن است هر از گاهی این شرایط را اصلاح کند. اطلاعیه‌های رسمی، از جمله تغییرات در شرایط، از طریق ایمیل به آدرس مرتبط با حساب فروشنده ارسال می‌شود.

۱۶.۲. فیلز همچنین می‌تواند برای به‌روزرسانی‌های عمومی، اعلان‌های سیستم یا یادآوری‌ها از پیام‌های درون برنامه‌ای، واتس‌اپ یا سایر روش‌های غیررسمی استفاده کند.

۱۶.۳. ادامه استفاده از پلتفرم پس از دریافت چنین اطلاعیه‌ای، به منزله پذیرش شرایط اصلاح شده است.
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  )
                      : const DefaultText(
                    '''
* شرائط و ضوابط (بیچنے والے)

مؤثر تاریخ: 01/01/2028
آخری اپ ڈیٹ: 06/26/2025

Fils کمیشن کے ایجنٹ اور تجارت کے ذریعے کمیشن کمپنی ("ہم"، "ہماری" یا "کمپنی") کے زیر ملکیت اور چلائے جانے والے Fils میں، ہمیں ایک ایسا پلیٹ فارم فراہم کرنے کا اعزاز حاصل ہے جہاں بیچنے والے شفاف، اچھی طرح سے ریگولیٹڈ نیلامیوں اور براہ راست فروخت کے ذریعے خریداروں سے رابطہ قائم کر سکتے ہیں۔ سروس کی یہ شرائط ("شرائط") ہمارے پلیٹ فارم ("پلیٹ فارم") کے ذریعے مصنوعات پیش کرنے والے فروخت کنندگان کے حقوق اور ذمہ داریوں کا خاکہ پیش کرتی ہیں۔ بیچنے والے کے طور پر رجسٹر کر کے، آپ مکمل طور پر ان شرائط سے اتفاق کرتے ہیں اور فہرست سازی، فروخت، اور Fils پر بیچنے والے کے طور پر اپنی ذمہ داریوں کو پورا کرنے میں شامل عمل کے بارے میں اپنی سمجھ کی تصدیق کرتے ہیں۔ اگر آپ کے کوئی سوالات ہیں، تو براہ کرم آگے بڑھنے سے پہلے ہم سے رابطہ کرنے میں سنکوچ نہ کریں۔

تعریفیں:

- پلیٹ فارم: درخواست اور ویب سائٹ سے مراد ہے جو Fils کمپنی کی ملکیت اور اس کے زیر انتظام ہے، بشمول ان سے وابستہ تمام خصوصیات، خدمات اور ٹولز۔
- صارف: کوئی بھی قدرتی یا قانونی شخص جو پلیٹ فارم پر اکاؤنٹ بناتا ہے، چاہے وہ خریدار، بولی لگانے والے، یا بیچنے والے کے طور پر، اور سروس کی ان شرائط کے ساتھ مشروط ہو۔
- بولی لگانے والا: وہ صارف جو پلیٹ فارم پر درج مصنوعات پر بولیاں لگا کر نیلامی میں حصہ لیتا ہے۔
- خریدار: وہ صارف جو پلیٹ فارم پر نیلامی یا براہ راست فروخت کے ذریعے مصنوعات خریدتا ہے۔
- بیچنے والا: وہ شخص یا ادارہ جو پلیٹ فارم پر اپنی مصنوعات فروخت یا نیلامی کے لیے پیش کرتا ہے، چاہے براہ راست یا Fils کے ذریعے کمیشن پر مبنی ایجنٹ کے طور پر۔
- فہرست سازی: پلیٹ فارم پر بیچنے والے کے ذریعہ شائع کردہ مصنوعات کی کوئی پیشکش یا اشتہار۔
- نیلامی: فروخت کا ایک طریقہ کار جس میں مصنوعات کو ایک مخصوص مدت کے لیے پیش کیا جاتا ہے، جس کے دوران بولیاں جمع کی جاتی ہیں، اور مدت کے اختتام پر سب سے زیادہ بولی لگانے والا جیت جاتا ہے۔
- بولی: نیلامی کے دوران پروڈکٹ خریدنے کی نیت سے بولی دہندہ کی طرف سے جمع کرائی گئی مالی پیشکش۔
- جیتنے والا بولی لگانے والا: وہ صارف جس نے نیلامی کے اختتام پر سب سے زیادہ بولی جمع کرائی اور اسے باضابطہ طور پر جیت کی اطلاع دی گئی۔
- براہ راست فروخت: ایک فروخت کا عمل جو خریدار کو نیلامی میں داخل کیے بغیر مخصوص قیمت پر فوری طور پر مصنوعات خریدنے کی اجازت دیتا ہے۔
- ریزرو پرائس: بیچنے والے کی طرف سے مقرر کردہ کم از کم قیمت، جسے فروخت کرنے کے لیے پورا کیا جانا چاہیے یا اس سے زیادہ ہونا چاہیے۔
- ابھی خریدیں: نیلامی ختم ہونے کا انتظار کیے بغیر ایک مخصوص قیمت پر پروڈکٹ فروخت کرنے کے لیے بیچنے والے کی طرف سے فراہم کردہ ایک آپشن۔
- پروڈکٹ: پلیٹ فارم پر فروخت یا نیلامی کے لیے پیش کردہ کوئی بھی فزیکل یا ڈیجیٹل آئٹم۔
- ایسکرو: بولی دہندہ کی سنجیدگی کو یقینی بنانے کے لیے فلز کے پاس عارضی طور پر رکھی گئی مالی رقم، اور بیان کردہ شرائط کے مطابق واپس کی جاتی ہے۔
- Fils Wallet: ایپلیکیشن کے اندر ایک بیلنس جو پلیٹ فارم پر ادائیگی کرنے کے لیے استعمال ہوتا ہے۔
- دستیاب بیلنس: وہ مالی قدر جسے صارف پلیٹ فارم پر اپنے بٹوے میں استعمال کر سکتا ہے۔
- انتظامی فیس: نیلامی، پلیٹ فارم، یا کچھ ٹرانزیکشنز پر کارروائی کرنے کے بدلے میں Fils کے ذریعے کٹوتی کی گئی کوئی بھی رقم۔
- واپسی کی پالیسی: شرائط کا ایک مجموعہ جو اس بات کی وضاحت کرتا ہے کہ خریدار پروڈکٹ کو کب اور کیسے واپس کر سکتا ہے اور ادا شدہ رقم واپس کر سکتا ہے۔
- تنازعہ: صارف اور Fils کے درمیان یا پروڈکٹ، سروس، یا استعمال کی شرائط سے متعلق دیگر صارفین کے درمیان کوئی اختلاف۔
- آفیشل نوٹس: پلیٹ فارم پر موجود صارف کے اکاؤنٹ سے وابستہ اس کے پتے پر ای میل کے ذریعے بھیجا گیا کوئی بھی پیغام۔
- گورننگ قانون: ریاست کویت میں نافذ قوانین جو سروس کی ان شرائط اور اس سے پیدا ہونے والے کسی بھی تنازعہ پر لاگو ہوتے ہیں۔
- مواد: پلیٹ فارم پر صارف کی طرف سے جمع کرائی گئی یا شائع کردہ تمام معلومات، متن، تصاویر، یا پیشکشوں کا حوالہ دیتا ہے۔

1. پلیٹ فارم پر فروخت کرنے کی اہلیت
1.1 یہ پلیٹ فارم کویت کی ریاست میں قانونی طور پر کام کرنے والے افراد اور کاروباروں کے لیے دستیاب ہے۔ بیچنے والوں کو یا تو ہونا چاہیے:
- کویت میں ایک درست تجارتی لائسنس کے ساتھ رجسٹرڈ کمپنی یا تجارتی ادارہ؛ یا
- کویتی قانون کے قانونی فریم ورک کے اندر تجارتی صلاحیت میں فروخت کرنے کا مجاز فرد (لائسنس ہولڈر: ایک ایجنٹ یا واحد ملکیت کا مالک)۔
1.2 فروخت کنندگان کے پاس قابل اطلاق کویتی قوانین کے تحت پابند معاہدوں میں داخل ہونے کی قانونی صلاحیت ہونی چاہیے۔

2. قابل اجازت اور ممنوع مصنوعات
2.1 بیچنے والے مصنوعات کی ایک وسیع رینج پیش کر سکتے ہیں، بشرطیکہ کویت کے قوانین کے تحت آئٹمز کو قانونی طور پر اجازت دی گئی ہو اور وہ پبلک آرڈر، شائستگی اور کمیونٹی کے معیارات کے مطابق ہوں۔
2.2 وہ اشیا جو بین الاقوامی طور پر ممنوع ہیں، کویتی قانون کے تحت محدود ہیں، یا جنہیں ثقافتی یا قانونی طور پر حساس سمجھا جاتا ہے، فہرست میں نہیں رکھا جا سکتا ہے۔ Fils اس بات کا تعین کرنے کے لیے صوابدید کو برقرار رکھتا ہے کہ آیا کوئی لسٹنگ نامناسب ہے یا اس سیکشن کی خلاف ورزی ہے اور ایسی فہرستوں کو پیشگی اطلاع کے بغیر ہٹا سکتی ہے۔

3. مصنوعات کی فہرست سازی کے تقاضے
3.1 ہر مصنوعات کی فہرست میں ایک واضح اور مکمل تفصیل شامل ہونی چاہیے۔ اس میں شامل ہیں، لیکن ان تک محدود نہیں ہے:
- مصنوعات کے طول و عرض، وزن، رنگ، اور حالت (نیا/استعمال شدہ)
- تیاری کا ملک
- کوئی معلوم نقائص، حدود، یا غائب اجزاء
3.2 فروخت کنندگان کو فروخت کے لیے پیش کردہ اصل پروڈکٹ کی واضح تصاویر اپ لوڈ کرنے کی ضرورت ہے۔ سیاق و سباق کے بغیر غلط، گمراہ کن، یا اسٹاک تصاویر کا استعمال سختی سے ممنوع ہے۔

4. قیمتوں کے تعین کے اختیارات
4.1 ریزرو قیمت (کم سے کم قابل قبول قیمت): بیچنے والے کم از کم قیمت کی وضاحت کر سکتے ہیں جس سے نیچے وہ فروخت کو قبول نہیں کریں گے۔ اگر بولی اس ریزرو قیمت تک نہیں پہنچتی ہے، تو لین دین خود بخود کالعدم ہو جائے گا اور فہرست کی میعاد ختم ہو جائے گی۔
4.2 ابھی خریدیں قیمت: پلیٹ فارم پر ایک ورچوئل سٹور چلانے والے بیچنے والے "ابھی خریدیں" قیمت مقرر کر سکتے ہیں، جس سے صارفین نیلامی کے عمل کو نظرانداز کر سکتے ہیں اور براہ راست آئٹم خرید سکتے ہیں۔ ایک فعال اسٹور کے بغیر بیچنے والے صرف ایک مقررہ قیمت کا اختیار استعمال کر سکتے ہیں اگر وہ براہ راست فروخت کے زمرے کا استعمال کرتے ہوئے آئٹم کی فہرست بناتے ہیں جو خاص طور پر غیر نیلامی لین دین کے لیے مخصوص ہے۔

5. ترامیم اور منسوخیاں
5.1 ایک بار بولی لگنے کے بعد، فہرست کو فعال سمجھا جاتا ہے اور بیچنے والے کے ذریعہ اس میں ترمیم یا ہٹایا نہیں جا سکتا۔
5.2 کوئی بھی بولی وصول کرنے سے پہلے، بیچنے والا اپنے ڈیش بورڈ کے ذریعے فہرست کو منسوخ کر سکتا ہے، بشرطیکہ کوئی پیشکش جمع نہ کی گئی ہو۔
5.3 وہ فہرستیں جو بولی وصول نہیں کرتی ہیں یا ریزرو قیمت تک پہنچنے میں ناکام رہتی ہیں وہ خود بخود ختم ہو جائیں گی اور پلیٹ فارم سے ہٹا دی جائیں گی۔

6. فیس اور کمیشن
6.1۔ Fils ایک کمیشن فیس (فی صد یا ایک مقررہ رقم) لاگو کرتا ہے جیسا کہ ہر مکمل فروخت پر فیس کے ڈھانچے میں بیان کیا گیا ہے، اور یہ فیس بیچنے والے کی واجب الادا رقم سے کاٹ لی جاتی ہے۔ فیس کا صحیح ڈھانچہ آپ کے سیلر ڈیش بورڈ میں دستیاب ہے۔ بیچنے والوں سے توقع کی جاتی ہے کہ وہ ان فیسوں کا بغور جائزہ لیں اور اگر وہ شرائط سے اتفاق نہیں کرتے ہیں تو انہیں اپنا اکاؤنٹ منسوخ کرنا چاہیے یا آئٹمز کی فہرست بند کرنا چاہیے۔
6.2 فائلز وقتاً فوقتاً فیس کے ڈھانچے پر نظر ثانی کر سکتی ہیں۔ اس طرح کی تبدیلیاں صرف تبدیلی کے بعد تخلیق کی گئی نئی فہرستوں پر ممکنہ طور پر لاگو ہوں گی۔

7. بیچنے والوں کو ادائیگی
7.1 خریدار کو شے کی کامیاب ترسیل اور اس کی حالت کی تصدیق کے بعد فروخت کنندگان کو اکیس (21) کاروباری دنوں کے اندر ادائیگی موصول ہوگی۔
7.2 اگر خریدار مقررہ مدت کے اندر رسید کی تصدیق نہیں کرتا ہے تو، Fils ڈیلیوری کی صورتحال کی چھان بین کرے گا اور، اپنی صوابدید پر، ادائیگی جاری کرنے کے ساتھ آگے بڑھ سکتا ہے۔

8. شپنگ اور ترسیل
8.1 بیچنے والے ڈیلیوری کا طریقہ منتخب کرنے کے ذمہ دار ہیں۔ وہ کر سکتے ہیں:
- Fils کے مربوط ڈیلیوری پارٹنرز میں سے ایک کا استعمال کریں؛ یا
- ڈیلیوری کو خود یا اپنے فراہم کنندہ کے ذریعے سنبھالیں۔
8.2 بیچنے والے کی پوری ذمہ داری ہے:
- بروقت ترسیل
- محفوظ پیکیجنگ
- ٹریکنگ کی تفصیلات فراہم کرنا (جہاں قابل اطلاق ہو)

9. تنازعات اور ذمہ داری
9.1 فہرستوں اور ادائیگیوں کی سہولت کے لیے Fils ایک ٹیکنالوجی پلیٹ فارم کے طور پر سختی سے کام کرتا ہے۔ Fils ذمہ داری قبول نہیں کرتا ہے:
- شپمنٹ کے دوران مصنوعات کا نقصان
- مصنوعات کی غلط بیانی
- بیچنے والے کے ذریعہ ڈیلیور کرنے میں ناکامی۔
9.2 بیچنے والا اور ان کا منتخب کردہ ڈیلیوری فراہم کنندہ خریدار کے ساتھ اس طرح کے مسائل کو حل کرنے کے لیے مکمل طور پر ذمہ دار ہے۔ Fils مواصلات کی سہولت فراہم کرنے میں محدود مدد فراہم کر سکتا ہے، لیکن لین دین کا فریق نہیں ہے۔

10. واپسی اور رقم کی واپسی کی پالیسی
10.1 ہر بیچنے والے کو فہرست یا اسٹور فرنٹ پر اپنی واپسی اور رقم کی واپسی کی پالیسی واضح طور پر بتانے کی ضرورت ہے۔ فائلز یکساں واپسی کی پالیسی نافذ نہیں کرتی ہے۔
10.2 اگر بیچنے والا کسی پالیسی کی وضاحت نہیں کرتا ہے، تو تمام فروخت کو حتمی سمجھا جائے گا، اور دھوکہ دہی یا بڑے نامعلوم نقائص کے علاوہ کوئی واپسی یا رقم کی واپسی نہیں دی جائے گی۔
11. احکامات کو پورا کرنے میں ناکامی۔
11.1 اگر کوئی بیچنے والا جیتنے والی بولی کے بعد آرڈر پورا کرنے میں ناکام رہتا ہے، تو درج ذیل نتائج لاگو ہوتے ہیں:
پہلا:
1. ایک باضابطہ انتباہ جاری کیا جائے گا۔
2. بیچنے والے کو خریدار کو نیلامی کی قیمت کے 10% کے ساتھ معاوضہ ادا کرنا ہوگا، جو ان کے اکاؤنٹ کے بیلنس یا مستقبل کی کمائی سے کاٹا جائے گا۔
دوسرا:
11.2 بار بار ناکامی اکاؤنٹ کی معطلی کا باعث بن سکتی ہے۔
تیسرا:
11.3 دوبارہ ہونے کی صورت میں، اس کے نتیجے میں اکاؤنٹ مستقل طور پر غیر فعال ہو جائے گا۔

12. احتیاط اور انتباہ
12.1 اگرچہ بیچنے والے لاجسٹک کوآرڈینیشن کے لیے پلیٹ فارم سے باہر خریداروں کے ساتھ بات چیت کر سکتے ہیں، Fils سختی سے تجویز کرتا ہے کہ شفافیت اور جوابدہی کے لیے پلیٹ فارم کے ذریعے تمام اہم مواصلتیں اور تصدیقیں ہوں۔
12.2. دھوکہ دہی کو روکنے اور دونوں فریقوں کی حفاظت کے لیے، فروخت کنندگان کو مشورہ دیا جاتا ہے کہ وہ لین دین کو حتمی شکل نہ دیں یا پلیٹ فارم سے باہر ادائیگیاں قبول نہ کریں۔ ایسا کرنے کے نتیجے میں تحفظ کے نقصان اور ممکنہ اکاؤنٹ کے جرمانے ہو سکتے ہیں۔

13. اکاؤنٹ معطل یا ختم کرنا
13.1 Fils بیچنے والے کے اکاؤنٹ کو معطل یا مستقل طور پر غیر فعال کر سکتا ہے ان صورتوں میں:
- یہاں بیان کردہ کسی بھی اصطلاح کی خلاف ورزی
- ممنوعہ یا نامناسب مصنوعات کی فہرست
- غلط یا گمراہ کن معلومات پیش کرنا
- ضرورت سے زیادہ شکایات موصول ہونا
- غیر اخلاقی یا غیر قانونی طرز عمل میں ملوث ہونا
13.2 سیلرز کو Fils سپورٹ سے رابطہ کرکے اور متعلقہ ثبوت فراہم کرکے کسی بھی تادیبی کارروائی کی اپیل کرنے کا حق ہے۔

14. ڈیٹا پروٹیکشن
14.1 Fils ادائیگی اور رابطے کی معلومات سمیت بیچنے والے کے ڈیٹا کی حفاظت اور رازداری کو یقینی بنانے کے لیے معقول حفاظتی اقدامات نافذ کرتا ہے۔
14.2 بیچنے والے کا ڈیٹا فروخت یا شیئر نہیں کیا جائے گا سوائے اس کے کہ جہاں ضروری ہو:
- مکمل لین دین
- ڈیلیوری کو پورا کریں۔
- قانونی ذمہ داریوں کی تعمیل کریں۔

15. گورننگ قانون اور دائرہ اختیار
15.1 یہ شرائط ریاست کویت کے قوانین کے مطابق چلتی ہیں اور ان کی تشکیل کی جائے گی۔
15.2 ان شرائط سے پیدا ہونے والا کوئی بھی تنازعہ کویت میں مجاز عدالتوں کے خصوصی دائرہ اختیار سے مشروط ہوگا۔

16. ترامیم اور نوٹسز
16.1 فائلز وقتاً فوقتاً ان شرائط میں ترمیم کر سکتی ہیں۔ باضابطہ اطلاعات، بشمول شرائط میں تبدیلیاں، بیچنے والے کے اکاؤنٹ سے وابستہ پتے پر ای میل کے ذریعے بھیجی جائیں گی۔
16.2 عام اپ ڈیٹس، سسٹم کی اطلاعات، یا یاد دہانیوں کے لیے، Fils درون ایپ پیغامات، WhatsApp، یا دیگر غیر رسمی ذرائع بھی استعمال کر سکتے ہیں۔
16.3 اس طرح کے نوٹس کی وصولی کے بعد پلیٹ فارم کا مسلسل استعمال نظر ثانی شدہ شرائط کی قبولیت پر مشتمل ہوگا۔
  ''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  ),

                  Row(
                    children: [
                      Checkbox(
                        value: checkP,
                        onChanged: (value) {
                          changeCheckP();
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: blackColor,
                              fontFamily: 'Almarai',
                            ),
                            children: [
                              TextSpan(
                                text: "I agree to".tr(),

                                style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                              TextSpan(
                                text: ' '.tr(),
                                style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                              TextSpan(
                                text: 'privacy policy'.tr(),
                                style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                              TextSpan(
                                text: ' '.tr(),
                                style: TextStyle(
                                  color: secondColor,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                              TextSpan(
                                text: 'and terms of use'.tr(),
                                style: TextStyle(
                                  color: secondColor,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if(checkP)
                    ButtonWidget(
                      onTap: ()async{
                        showBoatToast();
                        final json = await NetworkHelper.sendRequest(
                          requestType: RequestType.post,
                          endpoint: "seller-package/purchase-package",
                          fields: {"package_id": widget.id, "payment_provider": "ecom"},
                        );
                        closeAllLoading();
                        if (!json.containsKey("errorMessage")) {
                          ToWithFade(context, PaymentWebView(urlPayment: json['link']));
                        }
                      },
                      colorButton: primaryColor,
                      title: "Pay".tr(),
                    ),
                  SizedBox(height: 20),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}*/
