class Links {
  final String name;
  final String image;
  bool switchValue;

  Links(
    this.name,
    this.image,
    this.switchValue,
  );
}

List links = [
  Links('Facebook', 'assets/images/Facebook.png', false),
  Links('WhatsApp', 'assets/images/WhatsApp.png', false),
  Links('Dribble', 'assets/images/Dribbble.png', true),
  Links('Twitter', 'assets/images/Twitter.png', false),
];

class Links2 {
  final String name;
  final String image;

  Links2(
    this.name,
    this.image,
  );
}

List links2 = [
  Links2('Facebook', 'assets/images/Facebook.png'),
  Links2('Instagram', 'assets/images/Instagram.png'),
  Links2('Messenger', 'assets/images/Messenger.png'),
  Links2('Skype', 'assets/images/Skype.png'),
  Links2('LinkedIn', 'assets/images/LinkedIn.png'),
  Links2('WhatsApp', 'assets/images/WhatsApp.png'),
  Links2('Twitter', 'assets/images/Twitter.png'),
  Links2('Youtube', 'assets/images/YouTube.png'),
  Links2('Dribble', 'assets/images/Dribbble.png'),
];

class ListofPeople {
  final String image;
  final String name;
  final String desigination;

  ListofPeople(
    this.image,
    this.name,
    this.desigination,
  );
}

List listofpeople = [
  ListofPeople(
      'assets/images/connection1.png', 'Zuhran Ahmad', 'CEO at papertopixel'),
  ListofPeople(
      'assets/images/connection2.png', 'Faizan Ahmed', 'CEO at papertopixel'),
  ListofPeople('assets/images/connection3.png', 'Mukaram Hussain',
      'CEO at papertopixel'),
  ListofPeople(
      'assets/images/connection4.png', 'Hamza Ahmed', 'CEO at papertopixel'),
  ListofPeople(
      'assets/images/connection5.png', 'John Wick', 'CEO at papertopixel'),
  ListofPeople(
      'assets/images/connection6.png', 'Fatima Munir', 'CEO at papertopixel'),
];

//For Activate Device Page

class Device {
  final String name;
  final String image;

  Device(
    this.name,
    this.image,
  );
}

List device = [
  Device('Gotap', 'assets/images/devices/gotapsshop-01.png'),
  Device('Keychain', 'assets/images/devices/keychain.png'),
  Device('Event Badge', 'assets/images/devices/ebadge.png'),
  Device('Card', 'assets/images/devices/gotapscard.png'),
  Device('Band', 'assets/images/devices/gotapsbarcaletshop.png'),
  Device('Nomad Case', 'assets/images/devices/gotaps case.png'),
];

//For How to Tap Page

class ToTap {
  final String title1;
  final String title2;
  final String image;

  ToTap(
    this.title1,
    this.title2,
    this.image,
  );
}

List totap = [
  ToTap('Gotap to new iphones', 'Iphone 14, 13, 12, 11, XR, XS,',
      'assets/images/howtotap/Apple-iPhone-14-Pro-Deep-Purple-frontimage 1.png'),
  ToTap('Gotap to old iphones', 'IIphone X, 8, 7, 6',
      'assets/images/howtotap/iphone-8-zwart_600x600_BGresize_16777215-tj 1.png'),
  ToTap('Gotap to androids', 'Must have NFC on',
      'assets/images/howtotap/81-fNmQqlLL 1.png'),
  ToTap('Gotap with QR code', 'All Phones',
      'assets/images/howtotap/Group 33921.png'),
];

//For AddLinks

class AddLinksMain {
  final String image;
  final String title;

  AddLinksMain({
    required this.image,
    required this.title,
  });
}

class CategoryWithLinks {
  final String category;
  final List<AddLinksMain> alllinks2;

  CategoryWithLinks({
    required this.category,
    required this.alllinks2,
  });
}

List<CategoryWithLinks> allLinks = [
  CategoryWithLinks(
    category: 'Recommended',
    alllinks2: [
      AddLinksMain(
          image: 'assets/images/addlinks/icon.png', title: 'Phone Number'),
      AddLinksMain(image: 'assets/images/addlinks/Frame 1.png', title: 'Email'),
      AddLinksMain(
          image: 'assets/images/addlinks/Safari.png', title: 'Website'),
    ],
  ),
  CategoryWithLinks(
    category: 'Contact Info',
    alllinks2: [
      AddLinksMain(
          image: 'assets/images/addlinks/icon.png', title: 'Phone Number'),
      AddLinksMain(image: 'assets/images/addlinks/Frame 1.png', title: 'Email'),
      AddLinksMain(
          image: 'assets/images/addlinks/WhatsApp.png', title: 'Whatsapp'),
    ],
  ),
  CategoryWithLinks(
    category: 'Social Media',
    alllinks2: [
      AddLinksMain(
          image: 'assets/images/addlinks/Facebook.png', title: 'Facebook'),
      AddLinksMain(
          image:
              'assets/images/addlinks/InstagramOctDenoiserBeauty_001 copy.png',
          title: 'Instagram'),
      AddLinksMain(
          image: 'assets/images/addlinks/Twitter.png', title: 'Twitter'),
    ],
  ),
  CategoryWithLinks(
    category: 'Payments',
    alllinks2: [
      AddLinksMain(
          image: 'assets/images/addlinks/PaypalOctDenoiserBeauty_002 1.png',
          title: 'Paypal'),
      AddLinksMain(
          image: 'assets/images/addlinks/VimeoCombined_001.png',
          title: 'Venmo'),
    ],
  ),
  CategoryWithLinks(
    category: 'Music',
    alllinks2: [
      AddLinksMain(
          image: 'assets/images/addlinks/Spotify.png', title: 'Spotify'),
      AddLinksMain(
          image: 'assets/images/addlinks/SoundcloudOctDenoiserBeauty_002.png',
          title: 'Soundcloud'),
    ],
  ),
];
