import 'package:flutter/material.dart';
import '../../models/data_models.dart';
import '../../widgets/desktop/desktop_header.dart';
import 'desktop_orders_page.dart';

enum CheckoutStep { cart, address, payment, success }

enum PaymentMethod { card, upi, cod }

class DesktopCheckoutPage extends StatefulWidget {
  final List<ProductItem> cartItems;
  const DesktopCheckoutPage({super.key, required this.cartItems});

  @override
  State<DesktopCheckoutPage> createState() => _DesktopCheckoutPageState();
}

class _DesktopCheckoutPageState extends State<DesktopCheckoutPage> {
  CheckoutStep _currentStep = CheckoutStep.cart;
  bool _showAddressForm = true;
  PaymentMethod _selectedMethod = PaymentMethod.card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          DesktopHeader(cartCount: widget.cartItems.length),
          if (_currentStep != CheckoutStep.success &&
              _currentStep != CheckoutStep.cart)
            _buildStepper(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 40,
              ),
              child: _buildCurrentStepView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepIndicator("CART", CheckoutStep.cart),
          _buildStepDivider(),
          _buildStepIndicator("ADDRESS", CheckoutStep.address),
          _buildStepDivider(),
          _buildStepIndicator("PAYMENT", CheckoutStep.payment),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(String label, CheckoutStep step) {
    bool isCompleted = _currentStep.index > step.index;
    bool isActive = _currentStep == step;

    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted || isActive
                ? const Color(0xFF818CF8)
                : Colors.grey.shade200,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : Text(
                    "${step.index + 1}",
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: isActive ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStepDivider() {
    return Container(
      width: 40,
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.grey.shade200,
    );
  }

  Widget _buildCurrentStepView() {
    switch (_currentStep) {
      case CheckoutStep.cart:
        return _buildCartView();
      case CheckoutStep.address:
        return _buildAddressView();
      case CheckoutStep.payment:
        return _buildPaymentView();
      case CheckoutStep.success:
        return _buildSuccessView();
    }
  }

  // --- STEP 1: CART VIEW (NEW DESIGN) ---
  Widget _buildCartView() {
    double subtotal = widget.cartItems.fold(
      0,
      (sum, item) => sum + item.currentPrice,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "shopping cart",
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 60),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cart Items
                  ...widget.cartItems
                      .map((item) => _buildStylizedCartItem(item))
                      .toList(),
                ],
              ),
            ),
            const SizedBox(width: 80),
            // Right Column (Summary)
            Expanded(child: _buildStylizedSummary(subtotal)),
          ],
        ),
      ],
    );
  }

  Widget _buildStylizedCartItem(ProductItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(item.image, fit: BoxFit.contain),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title.toLowerCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  "mastercraft series",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                ),
              ],
            ),
          ),
          // Quantity Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(Icons.remove, size: 14, color: Colors.grey.shade400),
                const SizedBox(width: 15),
                const Text("1", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 15),
                Icon(Icons.add, size: 14, color: Colors.grey.shade400),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Text(
            "₹${item.currentPrice.toInt()}",
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          const SizedBox(width: 40),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close, color: Colors.black, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildStylizedSummary(double subtotal) {
    double processingFee = 200;
    double taxes = subtotal * 0.18;
    double total = subtotal + processingFee + taxes;

    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "summary",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 60),
          _buildSummaryLabelRow("coupon code", "0000"),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "e-voucher",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "+ add",
                style: TextStyle(
                  color: Color(0xFF818CF8),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          _buildSummaryDetailRow("subtotal", subtotal),
          _buildSummaryDetailRow("other processing fee", processingFee),
          _buildSummaryDetailRow("est taxes", taxes),
          const Divider(height: 60),
          _buildSummaryDetailRow("total", total, isBold: true),
          const SizedBox(height: 40),
          _buildSummaryDetailRow(
            "grand total",
            total,
            isBold: true,
            isLarge: true,
          ),
          const SizedBox(height: 60),
          SizedBox(
            width: double.infinity,
            height: 70,
            child: ElevatedButton(
              onPressed: () =>
                  setState(() => _currentStep = CheckoutStep.address),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF818CF8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                elevation: 0,
              ),
              child: const Text(
                "proceed to checkout",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryLabelRow(String label, String hint) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
          ),
        ),
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            hint,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade300,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryDetailRow(
    String label,
    double amount, {
    bool isBold = false,
    bool isLarge = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isBold ? const Color(0xFF1E293B) : Colors.grey,
              fontWeight: isBold ? FontWeight.w900 : FontWeight.w500,
              fontSize: isLarge ? 22 : 15,
            ),
          ),
          Text(
            "₹${amount.toInt()}",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: isLarge ? 22 : 15,
            ),
          ),
        ],
      ),
    );
  }

  // --- STEP 2: ADDRESS VIEW (NEW DESIGN) ---
  Widget _buildAddressView() {
    double subtotal = widget.cartItems.fold(
      0,
      (sum, item) => sum + item.currentPrice,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: The Form
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 40,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Shipping Address",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 40),
                if (_showAddressForm)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAddressTextField("Company's Name (Optional)"),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: _buildAddressTextField("Name")),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildAddressTextField("Phone Number"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: _buildAddressTextField("Pincode")),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildAddressTextField("Area / Street"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildAddressTextField(
                        "Address (Area and Street)",
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildAddressTextField(
                              "City / District / Town",
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(child: _buildAddressTextField("State")),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (val) {},
                            activeColor: const Color(0xFF10BB75),
                          ),
                          const Text(
                            "Same as Billing Address",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 30),
                          const Text(
                            "Add Billing Address",
                            style: TextStyle(
                              color: Color(0xFF10BB75),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () =>
                              setState(() => _showAddressForm = false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10BB75),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Save and Deliver here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  _buildSavedAddressCard(),
              ],
            ),
          ),
        ),
        const SizedBox(width: 60),
        // Right Column: Order Summary
        Expanded(
          flex: 2,
          child: Column(
            children: [
              // Stepper Mini
              _buildMiniStepper(),
              const SizedBox(height: 40),
              // Summary Details
              _buildDetailedOrderSummary(subtotal),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSavedAddressCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF10BB75), width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF10BB75),
                size: 24,
              ),
              const SizedBox(width: 15),
              const Text(
                "SHIPPING ADDRESS SELECTED",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 12,
                  color: Color(0xFF10BB75),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => setState(() => _showAddressForm = true),
                child: const Text(
                  "EDIT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Rohit Sengar",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            "123 Luxury Lane, Beverly Hills, CA 90210",
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          const SizedBox(height: 8),
          const Text(
            "Phone: +91 9876543210",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF10BB75)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildMiniStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Cart", style: TextStyle(color: Colors.grey, fontSize: 12)),
        const Text(" ------ ", style: TextStyle(color: Colors.grey)),
        const Text(
          "Delivery",
          style: TextStyle(
            color: Color(0xFF10BB75),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const Text(" ------ ", style: TextStyle(color: Colors.grey)),
        const Text(
          "Payment",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDetailedOrderSummary(double subtotal) {
    double deliveryCharges = 150;
    double totalPayable = subtotal + deliveryCharges;

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 40),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          _buildSummaryItem("Order Total", subtotal),
          _buildSummaryItem("Delivery Charges", deliveryCharges),
          const Divider(height: 60),
          const Text(
            "Delivery Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildDeliveryTypeCard(),
          const Divider(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Payable",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "₹${totalPayable.toInt()}",
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () =>
                  setState(() => _currentStep = CheckoutStep.payment),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5E5E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Place Order",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 15)),
          Text(
            "₹${amount.toInt()}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryTypeCard() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: NetworkImage(
                "https://images.unsplash.com/photo-1586769852836-bc069f19e1b6?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Standard Delivery",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                "Expected on 27 May, 2026",
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "₹120",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Text(
                    "Change",
                    style: TextStyle(
                      color: Color(0xFF10BB75),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- STEP 3: PAYMENT VIEW (MODERN DESIGN) ---
  Widget _buildPaymentView() {
    return Column(
      children: [
        // Method Selector Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSelectionPill("CREDIT CARD", PaymentMethod.card),
            const SizedBox(width: 20),
            _buildSelectionPill("UPI / QR", PaymentMethod.upi),
            const SizedBox(width: 20),
            _buildSelectionPill("CASH ON DELIVERY", PaymentMethod.cod),
          ],
        ),
        const SizedBox(height: 60),

        // Main Payment Interface
        Container(
          padding: const EdgeInsets.all(60),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 100,
                offset: const Offset(0, 30),
              ),
            ],
          ),
          child: _selectedMethod == PaymentMethod.card
              ? _buildCardPaymentInterface()
              : _buildOtherPaymentInterface(),
        ),
      ],
    );
  }

  Widget _buildSelectionPill(String label, PaymentMethod method) {
    bool isSelected = _selectedMethod == method;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF005CFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade200,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildCardPaymentInterface() {
    double subtotal = widget.cartItems.fold(
      0,
      (sum, item) => sum + item.currentPrice,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: The Form
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AceCoin Header
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF005CFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.credit_card,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "AceCoin",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const Text(
                    "Pay",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                  ),
                  const Spacer(),
                  _buildTimerDisplay(),
                ],
              ),
              const SizedBox(height: 50),

              // Fields
              _buildPaymentFieldHeader(
                "Card Number",
                "Enter the 16-digit card number on the card",
              ),
              _buildCardNumberInput(),
              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPaymentFieldHeader(
                          "CVV Number",
                          "Enter the 3 or 4 digit number",
                        ),
                        _buildPaymentInput(hint: "327", icon: Icons.apps),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPaymentFieldHeader(
                          "Expiry Date",
                          "Enter the expiration date",
                        ),
                        Row(
                          children: [
                            Expanded(child: _buildPaymentInput(hint: "09")),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "/",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: _buildPaymentInput(
                                hint: "22",
                                isSelected: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              _buildPaymentFieldHeader(
                "Password",
                "Enter your Dynamic password",
              ),
              _buildPaymentInput(
                hint: "••••••••",
                icon: Icons.apps,
                obscure: true,
              ),
              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () =>
                      setState(() => _currentStep = CheckoutStep.success),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005CFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 60),
        // Right Column: Virtual Card & Summary
        Expanded(flex: 2, child: _buildVirtualCardSummary(subtotal)),
      ],
    );
  }

  Widget _buildTimerDisplay() {
    return Row(
      children: ["0", "1", ":", "1", "9"].map((char) {
        if (char == ":")
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
          );
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            char,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPaymentFieldHeader(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              if (title == "Card Number")
                const Row(
                  children: [
                    Icon(Icons.edit, size: 14, color: Color(0xFF005CFF)),
                    SizedBox(width: 5),
                    Text(
                      "Edit",
                      style: TextStyle(
                        color: Color(0xFF005CFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCardNumberInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.credit_card, color: Colors.orange, size: 24),
          const SizedBox(width: 15),
          const Text(
            "2412 - 7512 - 3412 - 3456",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(Icons.verified, color: Color(0xFF00D1FF), size: 20),
        ],
      ),
    );
  }

  Widget _buildPaymentInput({
    required String hint,
    IconData? icon,
    bool isSelected = false,
    bool obscure = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? const Color(0xFF005CFF) : Colors.grey.shade100,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          const Spacer(),
          Text(
            hint,
            style: TextStyle(
              color: obscure ? Colors.black : const Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          if (icon != null) Icon(icon, color: Colors.grey.shade300, size: 20),
        ],
      ),
    );
  }

  Widget _buildVirtualCardSummary(double subtotal) {
    double vat = subtotal * 0.20;
    double total = subtotal + vat;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          // The Card
          Transform.translate(
            offset: const Offset(0, -30),
            child: _buildMiniVirtualCard(),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                _buildSummaryDetail("Company", "Apple", icon: Icons.apple),
                _buildSummaryDetail("Order Number", "1266201"),
                _buildSummaryDetail("Product", "Rudram Masterpiece"),
                _buildSummaryDetail("VAT (20%)", "₹${vat.toInt()}"),
              ],
            ),
          ),
          const Spacer(),
          // Bottom Total
          _buildPaymentTotalSection(total),
        ],
      ),
    );
  }

  Widget _buildMiniVirtualCard() {
    return Container(
      width: 220,
      height: 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.memory, color: Colors.grey, size: 40),
          const Spacer(),
          const Text(
            "Jonathan Michael",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 5),
          const Text(
            "•••• 3456",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "09/22",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const Icon(Icons.credit_card, color: Colors.orange, size: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryDetail(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(icon, size: 14, color: Colors.black),
                ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTotalSection(double total) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF2F7),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "You have to Pay",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "₹${total.toInt()}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.receipt_long, color: Color(0xFF1E293B), size: 30),
        ],
      ),
    );
  }

  Widget _buildOtherPaymentInterface() {
    return Center(
      child: Column(
        children: [
          if (_selectedMethod == PaymentMethod.upi) ...[
            const Icon(
              Icons.qr_code_scanner,
              size: 200,
              color: Color(0xFF1E293B),
            ),
            const SizedBox(height: 40),
            const Text(
              "Scan QR to Pay with UPI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Works with any UPI app like GPay, PhonePe, Paytm",
              style: TextStyle(color: Colors.grey),
            ),
          ] else ...[
            const Icon(
              Icons.local_shipping,
              size: 200,
              color: Color(0xFF10BB75),
            ),
            const SizedBox(height: 40),
            const Text(
              "Cash on Delivery Selected",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Pay securely at your doorstep",
              style: TextStyle(color: Colors.grey),
            ),
          ],
          const SizedBox(height: 60),
          SizedBox(
            width: 400,
            height: 70,
            child: ElevatedButton(
              onPressed: () =>
                  setState(() => _currentStep = CheckoutStep.success),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF005CFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Place Order",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- STEP 4: SUCCESS VIEW (PREMIUM DESIGN) ---
  Widget _buildSuccessView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          _buildPremiumSuccessHeader(),
          const SizedBox(height: 60),
          _buildOrderSuccessCard(),
          const SizedBox(height: 60),
          _buildSuccessOrderSummary(),
          const SizedBox(height: 80),
          _buildSuccessActionButtons(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildPremiumSuccessHeader() {
    return Column(
      children: [
        _buildAnimatedSuccessIcon(),
        const SizedBox(height: 30),
        const Text(
          "THANK YOU FOR YOUR ORDER",
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            color: Color(0xFF818CF8),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Your Payment was successful!",
          style: TextStyle(
            fontSize: 42,
            fontFamily: 'Serif',
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSuccessCard() {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 50,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _buildOrderStat(
                "ORDER ID",
                "#RD${DateTime.now().millisecond}09X",
                Icons.tag,
              ),
            ),
            VerticalDivider(color: Colors.grey.shade100, width: 40),
            Expanded(
              child: _buildOrderStat(
                "DELIVERY DATE",
                "Scheduled for 27 May, 2026",
                Icons.local_shipping_outlined,
              ),
            ),
            VerticalDivider(color: Colors.grey.shade100, width: 40),
            Expanded(
              child: _buildOrderStat(
                "STATUS",
                "Processing",
                Icons.auto_awesome,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStat(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessOrderSummary() {
    return Column(
      children: [
        const Text(
          "SHIPMENT DETAILS",
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.cartItems.length,
            separatorBuilder: (context, index) => const SizedBox(width: 25),
            itemBuilder: (context, index) {
              final item = widget.cartItems[index];
              return Container(
                width: 160,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(item.image, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "₹${item.currentPrice.toInt()}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 65,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E293B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0,
            ),
            child: const Text(
              "CONTINUE SHOPPING",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 250,
          height: 65,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DesktopOrdersPage(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF1E293B), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 18,
                  color: Color(0xFF1E293B),
                ),
                SizedBox(width: 10),
                Text(
                  "SEE ALL ORDERS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 250,
          height: 65,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF1E293B), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Color(0xFF1E293B),
                ),
                SizedBox(width: 10),
                Text(
                  "TRACK ORDER",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedSuccessIcon() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      curve: Curves.elasticOut,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Decorative Ring
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF4ADE80).withOpacity(0.2 * value),
                    width: 2,
                  ),
                ),
              ),
              // Inner Glow
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4ADE80).withOpacity(0.3 * value),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
              // Main Icon Circle
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF4ADE80),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
