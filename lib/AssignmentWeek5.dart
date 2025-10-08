import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Assignmentweek5 extends StatefulWidget {
  const Assignmentweek5({super.key});

  @override
  State<Assignmentweek5> createState() => _Assignmentweek5State();
}

class _Assignmentweek5State extends State<Assignmentweek5> {
  List<dynamic> products = [];

  // ✅ ฟังก์ชันแสดง SnackBar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:3000/products'),
      );
      if (response.statusCode == 200) {
        setState(() {
          products = jsonDecode(response.body);
        });
        showSnackBar("โหลดข้อมูลสำเร็จ");
      } else {
        showSnackBar("โหลดข้อมูลไม่สำเร็จ", isError: true);
      }
    } catch (e) {
      showSnackBar("เกิดข้อผิดพลาดในการโหลดข้อมูล", isError: true);
    }
  }

  Future<void> createProduct({
    required String name,
    required String description,
    required double price,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("http://localhost:3000/products"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "description": description,
          "price": price,
        }),
      );
      if (response.statusCode == 201) {
        await fetchData();
        showSnackBar("เพิ่มสินค้าสำเร็จ");
      } else {
        showSnackBar("เพิ่มสินค้าไม่สำเร็จ", isError: true);
      }
    } catch (e) {
      showSnackBar("เกิดข้อผิดพลาดในการเพิ่มสินค้า", isError: true);
    }
  }

  void showCreateDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("เพิ่มสินค้าใหม่"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ยกเลิก"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    priceController.text.isEmpty) {
                  showSnackBar("กรุณากรอกข้อมูลให้ครบ", isError: true);
                  return;
                }

                Navigator.pop(context);
                createProduct(
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.tryParse(priceController.text) ?? 0,
                );
              },
              child: Text("บันทึก"),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateProduct({
    required dynamic idUpdate,
    required String name,
    required String description,
    required double price,
  }) async {
    try {
      var response = await http.put(
        Uri.parse("http://localhost:3000/products/$idUpdate"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "description": description,
          "price": price,
        }),
      );
      if (response.statusCode == 200) {
        await fetchData();
        showSnackBar("อัปเดตสินค้าสำเร็จ");
      } else {
        showSnackBar("อัปเดตสินค้าไม่สำเร็จ", isError: true);
      }
    } catch (e) {
      showSnackBar("เกิดข้อผิดพลาดในการอัปเดตสินค้า", isError: true);
    }
  }

  void showUpdateDialog(
    int index,
    dynamic idUpdate,
    Map<String, dynamic> selectedItem,
  ) {
    TextEditingController nameController = TextEditingController(
      text: selectedItem['name'],
    );
    TextEditingController descriptionController = TextEditingController(
      text: selectedItem['description'],
    );
    TextEditingController priceController = TextEditingController(
      text: selectedItem['price'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("อัปเดตสินค้าลำดับที่ ${index + 1}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ยกเลิก"),
            ),
            ElevatedButton(
              onPressed: () {
                updateProduct(
                  idUpdate: idUpdate,
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.tryParse(priceController.text) ?? 0,
                );
                Navigator.pop(context);
              },
              child: Text("บันทึก"),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteProduct(dynamic idDelete) async {
    try {
      var response = await http.delete(
        Uri.parse("http://localhost:3000/products/$idDelete"),
      );
      if (response.statusCode == 200) {
        await fetchData();
        showSnackBar("ลบสินค้าสำเร็จ");
      } else {
        showSnackBar("ลบสินค้าไม่สำเร็จ", isError: true);
      }
    } catch (e) {
      showSnackBar("เกิดข้อผิดพลาดในการลบสินค้า", isError: true);
    }
  }

  void confirmDelete(dynamic idDelete, int index) {
    final item = products[index - 1]; // ✅ หารายการที่จะลบจาก index

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("ยืนยันการลบ"),
          content: Text(
            "คุณต้องการลบสินค้าลำดับที่ $index\n"
            "ชื่อ: ${item['name']}\n"
            "ราคาสินค้า: ${item['price']}\n"
            "จริงหรือไม่?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ยกเลิก"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                deleteProduct(idDelete); // ✅ ลบจริง
              },
              child: Text("ลบ"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 88, 140, 181),
        title: Text('Product', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: fetchData, child: Text('GET')),
              ElevatedButton(
                onPressed: showCreateDialog, // 🔹 เรียกฟังก์ชันเปิด dialog
                child: Text('POST'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (products.isEmpty) {
                    showSnackBar("ยังไม่มีข้อมูลสินค้า", isError: true);
                    return;
                  }

                  TextEditingController indexController =
                      TextEditingController();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("อัปเดตสินค้า"),
                        content: TextField(
                          controller: indexController,
                          decoration: InputDecoration(
                            labelText: "กรอกลำดับที่ต้องการแก้ไข",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("ยกเลิก"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              int? index = int.tryParse(indexController.text);
                              Navigator.pop(context);

                              if (index == null ||
                                  index <= 0 ||
                                  index > products.length) {
                                showSnackBar("ลำดับไม่ถูกต้อง", isError: true);
                                return;
                              }

                              // ✅ ดึงข้อมูลสินค้าตามลำดับ
                              final selectedItem = products[index - 1];

                              // ✅ เปิดหน้ากรอกข้อมูล โดยส่ง index, id และข้อมูลเดิมไปด้วย
                              showUpdateDialog(
                                index - 1,
                                selectedItem['id'],
                                selectedItem,
                              );
                            },
                            child: Text("ตกลง"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('PUT'),
              ),

              ElevatedButton(
                onPressed: () {
                  TextEditingController indexController =
                      TextEditingController();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete"),
                        content: TextField(
                          controller: indexController,
                          decoration: InputDecoration(
                            labelText: "กรอกลำดับที่ต้องการลบ ",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("ยกเลิก"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              int? index = int.tryParse(indexController.text);
                              Navigator.pop(context);

                              if (index == null ||
                                  index <= 0 ||
                                  index > products.length) {
                                showSnackBar("ลำดับไม่ถูกต้อง", isError: true);
                                return;
                              }

                              // ✅ ดึง id ของสินค้าตามลำดับที่กรอก
                              final idToDelete = products[index - 1]['id'];
                              confirmDelete(idToDelete, index);
                            },
                            child: Text("ลบ"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('DELETE'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];
                return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text(item['name']),
                  subtitle: Text(item['description']),
                  trailing: Text(
                    "${item['price']}",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
