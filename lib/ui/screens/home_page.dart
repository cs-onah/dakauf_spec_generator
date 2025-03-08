import 'dart:convert';

import 'package:dakauf_spec_generator/core/models/section_data.dart';
import 'package:dakauf_spec_generator/core/utils/context_extension.dart';
import 'package:dakauf_spec_generator/core/utils/string_extension.dart';
import 'package:dakauf_spec_generator/ui/widgets/section_container.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  List<SectionData> sections = [SectionData()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dakauf Spec Generator"), elevation: 1),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () async {
              sections.add(SectionData());
              setState(() {});
              await Future.delayed(Duration(milliseconds: 100));
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            },
            label: Text("Add Section"),
            icon: Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            onPressed: copySpecification,
            label: Text("Copy Spec"),
            icon: Icon(Icons.copy),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            onPressed: () async {
              sections = [];
              setState(() {});
              await Future.delayed(Duration(milliseconds: 100));
              sections = [SectionData()];
              setState(() {});
            },
            label: Text("Reset"),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Text(
              "Enter Product Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            ...sections.mapIndexed(
              (index, data) => SectionContainer(
                key: ValueKey(index),
                data: data,
                onChanged: (update) {
                  return sections[index] = update;
                },
                removeSection: () {
                  sections.removeAt(index);
                  setState(() {});
                },
              ),
            ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: ElevatedButton.icon(
            //     icon: Icon(Icons.add),
            //     onPressed: () async {
            //       sections.add(SectionData());
            //       setState(() {});
            //       await Future.delayed(Duration(milliseconds: 100));
            //       scrollController.animateTo(
            //         scrollController.position.maxScrollExtent,
            //         duration: Duration(milliseconds: 500),
            //         curve: Curves.linear,
            //       );
            //     },
            //     label: Text("Add Section"),
            //   ),
            // ),
            const SizedBox(height: 140),
          ],
        ),
      ),
    );
  }

  copySpecification() {
    if (!formKey.currentState!.validate()) return;

    try {
      /// Clean data
      final result = sections.where((value) {
        return !value.name.isEmptyOrNull;
      }).toList();

      /// Generate json map
      final resultMap = result.map((e) => e.toJson()).toList();

      /// convert to json string
      String jsonString = JsonEncoder.withIndent('    ').convert(resultMap);
      Clipboard.setData(ClipboardData(text: jsonString));
      debugPrint(jsonString);
      context.showSuccessSnackBar("Copied specification!");
    } catch (error) {
      context.showErrorSnackBar(error);
    }
  }
}
