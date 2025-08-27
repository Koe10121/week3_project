import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

final baseUrl = 'http://localhost:3000';
void main() async {
  print('==== Login ====');
  stdout.write('Username: ');
  String? username = stdin.readLineSync()?.trim();
  stdout.write('Password: ');
  String? password = stdin.readLineSync()?.trim();
  if (username == null || password == null) {
    print('Username and password cannot be empty.');
    return;
  }

  final url = Uri.parse("$baseUrl/login");
  final response = await http.post(
    url,
    body: {'username': username, 'password': password},
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    var userId = data["userId"];
    var username_loged = data["userName"];

    while (true) {
      print("========= Expense Tracking App =========");
      print("Welcome $username_loged");
      print("1. All expenses");
      print("2. Today's expense");
      print("3. Search expense");
      print("4. Add new expense");
      print("5. Delete an expense");
      print("6. Exit");
      stdout.write("Choose: ");
      String? choice = stdin.readLineSync()?.trim();
      if (choice == '6') {
        print("----- Bye -----");
        break;
      } else if (choice == '1') {
        await all_expenses(userId);
      } else if (choice == '2') {
        await today_expenses(userId);
      } else if (choice == '3') {
        await search_expense(userId);
      } else if (choice == '4') {
        await add_expense(userId);
      } else if (choice == '5') {
        await delete_expense(userId);
      } else {
        print("Invalid choice. Please try again.");
      }
    }
  } else if (response.statusCode == 401 || response.statusCode == 500) {
    final result = response.body;
    print(result);
  } else {
    print("Unknown error");
  }
}

Future<void> all_expenses(int userId) async {
  final url = Uri.parse("$baseUrl/expenses/$userId");
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final expenses = jsonDecode(response.body);
    int total = 0;
    print('---------- All expenses ----------');
    for (var expense in expenses) {
      print(
        '${expense['id']} : ${expense['item']} : ${expense['paid']} : ${expense['date']}',
      );
      total += expense['paid'] as int;
    }
    print(total);
  }
}

Future<void> today_expenses(int userId) async {
  final url = Uri.parse("$baseUrl/expenses/today/$userId");
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final expenses = jsonDecode(response.body);
    int total = 0;
    print("---------- Today's expenses ----------");
    for (var expense in expenses) {
      print(
        '${expense['id']} : ${expense['item']} : ${expense['paid']} : ${expense['date']}',
      );
      total += expense['paid'] as int;
    }
    print(total);
  }
}

Future<void> search_expense(int userId) async {
  stdout.write('Item to search: ');
  String? item = stdin.readLineSync()?.trim();

  final url = Uri.parse("$baseUrl/expenses/search/$userId?item=$item");
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final expenses = jsonDecode(response.body);

    print('---------- Search expenses ----------');
    if (expenses.isEmpty) {
      print('No item: $item');
    } else {
      for (var expense in expenses) {
        print(
          '${expense['id']} : ${expense['item']} : ${expense['paid']} : ${expense['date']}',
        );
      }
    }
  }
}

Future<void> add_expense(int userId) async {
  stdout.write('Item: ');
  String? item = stdin.readLineSync()?.trim();
  stdout.write('Paid: ');
  String? paidStr = stdin.readLineSync()?.trim();
  int? paid = int.tryParse(paidStr ?? '');
  if (item == null || paid == null) {
    print('Item and paid amount cannot be empty.');
    return;
  }

  final url = Uri.parse("$baseUrl/expenses");
  final response = await http.post(
    url,
    body: {'userId': userId.toString(), 'item': item, 'paid': paid.toString()},
  );
  if (response.statusCode == 201) {
    final result = response.body;
    print(result);
  } else if (response.statusCode == 400) {
    final result = response.body;
    print(result);
  } else if (response.statusCode == 500) {
    final result = response.body;
    print(result);
  }
}

Future<void> delete_expense(int userId) async {
  print('===== Delete an item =====');
  stdout.write('Item id:');
  String? idStr = stdin.readLineSync()?.trim();
  int? id = int.tryParse(idStr ?? '');
  if (id == null) {
    print('Invalid expense ID.');
    return;
  }

  final url = Uri.parse("$baseUrl/expenses/$id");
  final response = await http.delete(url);
  if (response.statusCode == 200) {
    final result = response.body;
    print(result);
  } else if (response.statusCode == 404) {
    final result = response.body;
    print(result);
  } else {
    print('Unknown error');
  }
}
