import 'dart:io';

void main() async {
  final dir = Directory('../../assets/icons/');
  final List<FileSystemEntity> entities = await dir.list().toList();

  // Create a list to store file names
  List<String> fileNames = [];

  // Extract file names from the list of entities
  entities.forEach((entity) {
    if (entity is File) {
      fileNames.add(entity.path.split('/').last);
    }
  });

  // Generate the content to write to the file
  String fileContent = '''
  final List<String> iconNames = [
    ${fileNames.map((fileName) => "'$fileName',").join('\n    ')}
  ];
  ''';

  // Define the output directory
  String outputDir = '../output/generated';

  // Create the output directory if it doesn't exist
  await Directory(outputDir).create(recursive: true);

  // Write the content to a Dart file in the output directory
  File outputFile = File('$outputDir/icon_names.dart');
  await outputFile.writeAsString(fileContent);

  print('File generated successfully: ${outputFile.path}');
}
