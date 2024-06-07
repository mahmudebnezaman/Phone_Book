import 'package:flutter/material.dart';
import 'package:phone_book/entitites/contact_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ContactInfo> _contactList = [];

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _numberTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameTEController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Name',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Contact Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _numberTEController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Number',
                      hintText: 'Number',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Contact Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ContactInfo contactInfo = ContactInfo(
                          _nameTEController.text.trim(),
                          _numberTEController.text.trim(),
                        );
                        _addNewContact(contactInfo);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Contact Added'),
                          ),
                        );
                        _nameTEController.clear();
                        _numberTEController.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    child: const Text('Add'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Visibility(
                visible: _contactList.isNotEmpty,
                replacement: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.contacts_outlined,
                      size: 100,
                      color: Colors.blueGrey,
                    ),
                    Text('Contact List is Empty!'),
                  ],
                ),
                child: ListView.builder(
                  itemCount: _contactList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        _showDeleteDialog(index);
                      },
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.account_box),
                          title: Text(_contactList[index].name),
                          subtitle: Text(_contactList[index].number),
                          trailing: const Icon(Icons.call),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewContact(ContactInfo contactInfo) {
    _contactList.add(contactInfo);
    if (mounted) {
      setState(() {});
    }
  }

  void _deleteContact(int index) {
    _contactList.removeAt(index);
    Navigator.pop(context);
    if (mounted) {
      setState(() {});
    }
  }

  void _showDeleteDialog(index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure for Delete?'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel),
          ),
          IconButton(
            onPressed: () {
              _deleteContact(index);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
