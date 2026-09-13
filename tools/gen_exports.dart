import 'dart:io';

void main(List<String> args) {
  if (args.length != 1) {
    stderr.writeln(
      'Cách dùng: dart run tools/gen_exports.dart <package>',
    );
    stderr.writeln(
      'Ví dụ: dart run tools/gen_exports.dart data',
    );
    exitCode = 1;
    return;
  }

  // Tự động export vào file của package
  // > dart run tools/gen_exports.dart X  ---> Với X là tên package
  // >> Ví dụ dart run tools/gen_exports.dart data (nó sẽ được export vào file data.dart của package data)
  final packageName = args[0];

  // Ví dụ:
  //
  // dart run tools/gen_exports.dart data
  //   -> data/lib/src/
  //   -> data/lib/data.dart
  //
  // dart run tools/gen_exports.dart domain
  //   -> domain/lib/src/
  //   -> domain/lib/domain.dart
  //
  // Tool CHỈ hoạt động trong package được truyền vào.

  final packageDir = Directory(packageName);
  final srcDir = Directory('$packageName/lib/src');
  final barrelFile = File('$packageName/lib/$packageName.dart');

  // Kiểm tra package tồn tại
  if (!packageDir.existsSync()) {
    stderr.writeln('Không tìm thấy package: $packageName');
    exitCode = 1;
    return;
  }

  // Kiểm tra barrel file tồn tại
  if (!barrelFile.existsSync()) {
    stderr.writeln(
      'Không tìm thấy barrel file: '
          '$packageName/lib/$packageName.dart',
    );
    exitCode = 1;
    return;
  }

  // Tìm thư mục chứa source code (src hoặc trực tiếp lib/)
  final libDir = Directory('$packageName/lib');
  final useSrcSubdir = srcDir.existsSync();
  final scanDir = useSrcSubdir ? srcDir : libDir;

  final exports = <String>[];

  // Quét thư mục nguồn
  for (final entity in scanDir.listSync(recursive: true)) {
    if (entity is! File) continue;
    if (!entity.path.endsWith('.dart')) continue;

    final fileName = entity.uri.pathSegments.last;

    // Bỏ file private
    if (fileName.startsWith('_')) continue;

    // Bỏ file generated
    if (fileName.endsWith('.g.dart')) continue;
    if (fileName.endsWith('.freezed.dart')) continue;
    
    // Bỏ các file config được generate tự động (tránh conflict extension)
    if (fileName == 'di.config.dart') continue;
    if (fileName == 'objectbox.g.dart') continue;

    // Bỏ barrel file chính
    if (entity.path == barrelFile.path) continue;

    final normalizedPath = entity.path.replaceAll(r'\', '/');

    final libPrefix = '$packageName/lib/';

    if (!normalizedPath.startsWith(libPrefix)) {
      continue;
    }

    // Tính relative path
    // Có src/: domain/lib/src/user/user.dart -> src/user/user.dart
    // Không có src/: app/lib/ui/home/home_page.dart -> ui/home/home_page.dart
    final relativePath = normalizedPath.substring(libPrefix.length);

    exports.add(
      "export '$relativePath';",
    );
  }

  // Sort alphabetically
  exports.sort();

  final lines = barrelFile.readAsLinesSync();

  // Chỉ xóa các export bắt đầu bằng src/ hoặc bất kỳ đường dẫn nào
  //
  // Ví dụ:
  // export 'src/user/user.dart';       <- bị generate lại
  // export 'ui/home/home_page.dart';   <- bị generate lại
  //
  // Còn:
  // export '../helper/foo.dart';       <- giữ nguyên
  final preserved = lines.where((line) {
    final trimmed = line.trim();

    return !(
        trimmed.startsWith("export '") ||
            trimmed.startsWith('export "')
    );
  }).toList();

  // Xóa dòng trống cuối file
  while (
  preserved.isNotEmpty &&
      preserved.last.trim().isEmpty) {
    preserved.removeLast();
  }

  // Thêm exports mới
  if (exports.isNotEmpty) {
    if (preserved.isNotEmpty) {
      preserved.add('');
    }

    preserved.addAll(exports);
  }

  preserved.add('');

  barrelFile.writeAsStringSync(
    preserved.join('\n'),
  );

  stdout.writeln(
    'Đã generate ${exports.length} exports vào '
        '$packageName/lib/$packageName.dart',
  );
}
