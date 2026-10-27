import 'package:flutter/material.dart';

void main() => runApp(const POSRetailApp());

const Color brandBlue = Color(0xFF1769D2);
const Color darkBlue = Color(0xFF234E78);
const Color paleBlue = Color(0xFFEAF3FC);
const Color ink = Color(0xFF172B4D);
const Color muted = Color(0xFF718096);

class Product {
  final String name;
  final String category;
  final int price;
  int stock;

  Product(this.name, this.category, this.price, this.stock);
}

final List<Product> sampleProducts = [
  Product('Coca Cola 500ml', 'Beverages', 2500, 50),
  Product('Sprite 500ml', 'Beverages', 2500, 40),
  Product('Water 500ml', 'Beverages', 1500, 100),
  Product('Bread', 'Groceries', 3000, 30),
  Product('Chips', 'Snacks', 2000, 45),
];

String money(int value) =>
    'UGX ${value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';

void go(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

class POSRetailApp extends StatelessWidget {
  const POSRetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POS Retail Pro',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: brandBlue),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: ink,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: muted, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFDCE4EF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFDCE4EF)),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: paleBlue,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: brandBlue,
                    size: 58,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'POS Retail Pro',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Manage your business\nanytime, anywhere',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: muted, height: 1.5),
                ),
                const SizedBox(height: 45),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => go(context, const LoginScreen()),
                    child: const Text('Get Started'),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Version 1.0.0',
                  style: TextStyle(fontSize: 11, color: muted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
            const Text(
              'Sign in to your account',
              style: TextStyle(color: muted),
            ),
            const SizedBox(height: 26),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                hintText: 'Email or Phone',
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: password,
              obscureText: obscure,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => obscure = !obscure),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () =>
                    _message(context, 'Password reset flow can be added here.'),
                child: const Text('Forgot password?'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => go(context, const HomeScreen()),
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: () => go(context, const HomeScreen()),
              icon: const Icon(Icons.g_mobiledata, size: 28),
              label: const Text('Continue with Google'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => go(context, const HomeScreen()),
              icon: const Icon(Icons.apple),
              label: const Text('Continue with Apple'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final pages = const [
    DashboardTab(),
    ProductsScreen(),
    InventoryScreen(),
    CustomersScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POS Retail Pro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => _message(context, 'No new notifications.'),
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.warehouse_outlined),
            label: 'Inventory',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            label: 'Customers',
          ),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Good Morning,', style: TextStyle(color: muted)),
        const Text(
          'Business Owner',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: brandBlue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Sales", style: TextStyle(color: Colors.white70)),
              SizedBox(height: 6),
              Text(
                'UGX 1,250,000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _actionTile(
              context,
              Icons.point_of_sale,
              'New Sale',
              () => go(context, const SaleScreen()),
            ),
            _actionTile(
              context,
              Icons.inventory_2,
              'Inventory',
              () => go(context, const InventoryScreen()),
            ),
            _actionTile(
              context,
              Icons.people,
              'Customers',
              () => go(context, const CustomersScreen()),
            ),
            _actionTile(
              context,
              Icons.bar_chart,
              'Reports',
              () => go(context, const ReportsScreen()),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Recent Transactions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        const TransactionRow(
          icon: Icons.money,
          title: 'Cash Sale',
          amount: 'UGX 45,000',
          time: '10:24 AM',
        ),
        const TransactionRow(
          icon: Icons.credit_card,
          title: 'Card Payment',
          amount: 'UGX 120,000',
          time: '09:50 AM',
        ),
      ],
    );
  }
}

Widget _actionTile(
  BuildContext context,
  IconData icon,
  String title,
  VoidCallback action,
) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    child: InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: action,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: brandBlue, size: 30),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}

class TransactionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final String time;

  const TransactionRow({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    elevation: 0,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: paleBlue,
        child: Icon(icon, color: brandBlue),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(time),
      trailing: Text(
        amount,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String query = '';
  String category = 'All';

  @override
  Widget build(BuildContext context) {
    final products = sampleProducts.where((product) {
      return (category == 'All' || product.category == category) &&
          product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search products...',
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: ['All', 'Beverages', 'Snacks', 'Groceries'].map((
                value,
              ) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(value),
                    selected: category == value,
                    onSelected: (_) => setState(() => category = value),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView(
              children: products.map((product) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: paleBlue,
                    child: Icon(Icons.shopping_bag_outlined, color: brandBlue),
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                    '${money(product.price)}  |  Stock: ${product.stock}',
                  ),
                  trailing: IconButton(
                    onPressed: () =>
                        _message(context, '${product.name} selected.'),
                    icon: const Icon(Icons.add_circle, color: brandBlue),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final Map<Product, int> cart = {};

  int get subtotal =>
      cart.entries.fold(0, (sum, entry) => sum + entry.key.price * entry.value);
  int get tax => (subtotal * .16).round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Sale')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select items',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          ...sampleProducts.map(
            (product) => ListTile(
              title: Text(product.name),
              subtitle: Text(money(product.price)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      if ((cart[product] ?? 0) > 1) {
                        cart[product] = cart[product]! - 1;
                      } else {
                        cart.remove(product);
                      }
                    }),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text('${cart[product] ?? 0}'),
                  IconButton(
                    onPressed: () => setState(
                      () => cart[product] = (cart[product] ?? 0) + 1,
                    ),
                    icon: const Icon(Icons.add_circle, color: brandBlue),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 28),
          _moneyRow('Subtotal', subtotal),
          _moneyRow('Tax (16%)', tax),
          _moneyRow('Total', subtotal + tax, bold: true),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: cart.isEmpty
                ? null
                : () => _message(
                    context,
                    'Sale recorded: ${money(subtotal + tax)}',
                  ),
            child: const Text('Complete Sale'),
          ),
        ],
      ),
    );
  }
}

Widget _moneyRow(String label, int amount, {bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          money(amount),
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: ListView(
        children: sampleProducts.map((product) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: paleBlue,
              child: Icon(Icons.inventory_2_outlined, color: brandBlue),
            ),
            title: Text(product.name),
            subtitle: Text('Stock: ${product.stock}  |  Reorder: 20'),
            trailing: const Icon(Icons.chevron_right),
          );
        }).toList(),
      ),
    );
  }
}

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final search = TextEditingController();
  final names = [
    'John Mwangi',
    'Sarah Nakato',
    'David Kato',
    'Aisha Namulindwa',
    'Peter Ssemanda',
  ];

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = names
        .where((name) => name.toLowerCase().contains(search.text.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: search,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search customers...',
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: filtered
                  .map(
                    (name) => ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person_outline),
                      ),
                      title: Text(name),
                      subtitle: const Text('+256 700 123 456'),
                      onTap: () => _message(context, 'Customer profile: $name'),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports & Analytics')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Total Sales', style: TextStyle(color: muted)),
          SizedBox(height: 8),
          Text(
            'UGX 8,450,000',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Sales Trend',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: CustomPaint(painter: SalesChartPainter()),
          ),
        ],
      ),
    );
  }
}

class SalesChartPainter extends CustomPainter {
  const SalesChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = brandBlue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final points = [
      Offset(0, size.height * .78),
      Offset(size.width * .25, size.height * .6),
      Offset(size.width * .5, size.height * .48),
      Offset(size.width * .75, size.height * .38),
      Offset(size.width, size.height * .18),
    ];
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(
              'Business Owner',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('owner@business.com'),
          ),
          ListTile(
            leading: const Icon(Icons.store_outlined, color: brandBlue),
            title: const Text('Business Profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _message(context, 'Business profile'),
          ),
          ListTile(
            leading: const Icon(Icons.tune, color: brandBlue),
            title: const Text('App Preferences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _message(context, 'App preferences'),
          ),
        ],
      ),
    );
  }
}

void _message(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
