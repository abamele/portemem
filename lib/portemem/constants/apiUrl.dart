class AppUrl{
  static const String baseUrl = "https://crm.portemem.com:443";

  static const String login = ("$baseUrl/api/takvimim/kullanici-giris");

  //Get List of Data
  static const String customerList = ("$baseUrl/api/musteri/musteriler");
  static const String userList = ("$baseUrl/api/Kullanici/kullanicilar");
  static const String meetingList = ("$baseUrl/api/gorusme/gorusmeler");
  static const String taskList = ("$baseUrl/api/gorev/tum-gorevler");
  static const String myNomtaskList = ("$baseUrl/api/gorev/atadigim-gorevler");
  static const String myTaskRespList = ("$baseUrl/api/gorev/sorumlu-oldugum-gorevlerim");
  static const String contactList = ("$baseUrl/api/yetkili/yetkililer");
  static const String tasktypeList = ("$baseUrl/api/takvimim/gorev-tipi-listesi");
  static const String allCategory = ("$baseUrl/api/musteri/tüm-kategorileri-getir");
  static const String allCalender = ("$baseUrl/api/takvimim/takvim-tum-toplantilari-getir");
  static const String taskListDropdown = ("$baseUrl/api/gorev/gorev-atayan-ve-sorumlu-listesi");
  static const String getAllMeeting = ("$baseUrl/api/takvimim/takvim-tum-toplantilari-getir");
  static const String finacialStatement = ("$baseUrl/api/takvimim/mali-tablo-getir");

  //Add Data
  static const String addCustomer = ("$baseUrl/api/musteri/musteri-ekle");
  static const String addUser = ("$baseUrl/api/Kullanici/kullanici-ekle");
  static const String addContact = ("$baseUrl/api/yetkili/yetkili-ekle");
  static const String addMeeting = ("$baseUrl/api/gorusme/gorusme-ekle");

  static const String addTask = ("$baseUrl/api/gorev/gorev-ekle");
  static const String addAktivity = ("$baseUrl/api/aktivite/aktivite-ekle");
  static const String addOffer = ("$baseUrl/api/teklif/teklif-ekle");
  static const String addProductBasket = ("$baseUrl/api/teklif/teklife-sepet-ekle");
  static const String addScope = ("$baseUrl/api/firsat/firsat-ekle");
  static const String addProduct = ("$baseUrl/api/urun/urun-ekle");
  static const String addCurrency = ("$baseUrl/api/parabirimleri/para-birimi-ekle");
  static const String addCauseRefuse = ("$baseUrl/api/rednedenleri/rednedenleri-ekle");
  static const String addCanlendarTask = ("$baseUrl/api/takvimim/gorev-tipi-ekle");
  static const String addMyCalendar = ("$baseUrl/api/takvimim/yeni-not-ekle");
  static const String addFinaicalStatement = ("$baseUrl/api/takvimim/yeni-malitablo-ekle");

  //Update Data
  static const String updateUser = ("$baseUrl/api/Kullanici/kullanici-guncelle");
  static const String updateCustomer = ("$baseUrl/api/musteri/musteri-guncelle");


}