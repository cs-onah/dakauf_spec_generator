import 'package:dakauf_spec_generator/core/models/attribute.dart';
import 'package:dakauf_spec_generator/core/models/section_data.dart';
import 'package:dakauf_spec_generator/ui/widgets/attribute_container.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class SectionContainer extends StatefulWidget {
  final SectionData data;
  final Function(SectionData)? onChanged;
  final VoidCallback? removeSection;
  const SectionContainer({
    super.key,
    required this.data,
    this.onChanged,
    this.removeSection,
  });
  @override
  State<SectionContainer> createState() => _SectionContainerState();
}

class _SectionContainerState extends State<SectionContainer> {
  SectionData data = SectionData();

  final name = TextEditingController();

  List<Attribute> attributes = [
    Attribute(),
  ];

  @override
  void initState() {
    data = widget.data;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      name.text = data.name ?? '';
      attributes = data.attributes.isEmpty ? [Attribute()] : data.attributes;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "New Specification Section",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: widget.removeSection,
                label: Text("Remove Section"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              final updatedData = data.copyWith(name: value);
              data = updatedData;
              widget.onChanged?.call(updatedData);
            },
            decoration: InputDecoration(
              label: Text("Section Header e.g (Network)"),
            ),
          ),
          const SizedBox(height: 20),
          Text("Section Attributes"),
          const SizedBox(height: 8),
          ...attributes.mapIndexed((index, data) {
            return AttributeContainer(
              key: ValueKey(index),
              data: data,
              onChanged: (update) {
                attributes[index] = update;
                onAttributeUpdate(update);
              },
              remove: () {
                attributes.removeAt(index);
                setState(() {});
              },
            );
          }),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {
              attributes.add(Attribute());
              setState(() {});
            },
            label: Text("Add Attribute"),
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }

  onAttributeUpdate(Attribute update) {
    final updatedData = data.copyWith(attributes: attributes);
    widget.onChanged?.call(updatedData);
  }
}
