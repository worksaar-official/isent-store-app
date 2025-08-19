class ModulePermissionBodyModel{
  bool? item;
  bool? order;
  bool? storeSetup;
  bool? addon;
  bool? wallet;
  bool? bankInfo;
  bool? employee;
  bool? myShop;
  bool? customRole;
  bool? campaign;
  bool? reviews;
  bool? pos;
  bool? chat;
  bool? myWallet;
  bool? banner;
  bool? coupon;
  bool? report;

  ModulePermissionBodyModel({
    this.item,
    this.order,
    this.storeSetup,
    this.addon,
    this.wallet,
    this.bankInfo,
    this.employee,
    this.myShop,
    this.customRole,
    this.campaign,
    this.reviews,
    this.pos,
    this.chat,
    this.myWallet,
    this.banner,
    this.coupon,
    this.report,
  });

  ModulePermissionBodyModel.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    order = json['order'];
    storeSetup = json['store_setup'];
    addon = json['addon'];
    wallet = json['wallet'];
    bankInfo = json['bank_info'];
    employee = json['employee'];
    myShop = json['myShop'];
    customRole = json['custom_role'];
    campaign = json['campaign'];
    reviews = json['reviews'];
    pos = json['pos'];
    chat = json['chat'];
    myWallet = json['my_wallet'];
    banner = json['banner'];
    coupon = json['coupon'];
    report = json['report'];
  }

  Map<String, bool?> toJson() {
    final Map<String, bool?> data = <String, bool?>{};
    data['item'] = item ;
    data['order'] = order;
    data['store_setup'] = storeSetup;
    data['addon'] = addon;
    data['wallet'] = wallet;
    data['bank_info'] = bankInfo;
    data['employee'] = employee;
    data['my_shop'] = myShop;
    data['custom_role'] = customRole;
    data['campaign'] = campaign;
    data['reviews'] = reviews;
    data['pos'] = pos;
    data['chat'] = chat;
    data['my_wallet'] = myWallet;
    data['banner'] = banner;
    data['coupon'] = coupon;
    data['report'] = report;
    return data;
  }
}