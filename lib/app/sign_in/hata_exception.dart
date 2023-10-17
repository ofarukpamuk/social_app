class Hatalar {
  static String goster(String hataKodu) {
    switch (hataKodu) {
      case 'email-already-in-use':
        return "Bu email adresi zaten kullanılıyor";
      case 'user-not-found':
        return "Bu kullanıcı sistemde bulunmamaktadır. Lütfen bir kullanıcı oluşturunuz";
      default:
        return "Bir hata oluştu";
    }
  }
}
