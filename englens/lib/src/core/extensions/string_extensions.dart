extension StringExtensions on String {
  String snakeCaseToNormal() {
    if (this.isEmpty) return ""; // Kiểm tra chuỗi rỗng để tránh lỗi

    return this
        .split('_') // Tách chuỗi tại dấu gạch dưới
        .where(
          (word) => word.isNotEmpty,
        ) // Loại bỏ các khoảng trống thừa nếu có __
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' '); // Ghép lại bằng dấu cách
  }
}
