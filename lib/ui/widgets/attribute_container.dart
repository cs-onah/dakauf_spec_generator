import 'package:dakauf_spec_generator/core/models/attribute.dart';
import 'package:flutter/material.dart';

class AttributeContainer extends StatefulWidget {
  final Attribute data;
  final Function(Attribute)? onChanged;
  final VoidCallback? remove;
  const AttributeContainer({
    super.key,
    required this.data,
    this.onChanged,
    this.remove,
  });

  @override
  State<AttributeContainer> createState() => _AttributeContainerState();
}

class _AttributeContainerState extends State<AttributeContainer> {
  final name = TextEditingController();
  final value = TextEditingController();
  Attribute data = Attribute();
  @override
  void initState() {
    data = widget.data;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      name.text = widget.data.name ?? '';
      value.text = widget.data.value ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: name,
              onChanged: (value) {
                final updatedData = data.copyWith(name: value);
                data = updatedData;
                widget.onChanged?.call(updatedData);
              },
              decoration: InputDecoration(hintText: "Name (e.g Weight)"),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: value,
              onChanged: (value) {
                final updatedData = data.copyWith(value: value);
                data = updatedData;
                widget.onChanged?.call(updatedData);
              },
              decoration: InputDecoration(hintText: "Information (e.g 5kg)"),
            ),
          ),
          IconButton(
            onPressed: widget.remove,
            icon: Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
