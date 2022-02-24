import 'package:flutter/material.dart';
import 'package:status_saver/index.dart';

class BuildImages extends StatelessWidget {
  final List<String> files;
  final bool isLoading;
  const BuildImages({
    Key? key,
    required this.files,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 12.0,
        ),
        child: files.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: files.length,
                itemBuilder: (BuildContext context, int index) {
                  return ImageTile(
                    file: files[index],
                    isLoading: isLoading,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewImage(
                            image: files[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : const NoImagesToshow(),
      ),
    );
  }
}
