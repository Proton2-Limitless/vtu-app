class UsertypeModel {
  final String usertype;
  final String description;

  const UsertypeModel({
    required this.description,
    required this.usertype,
  });
}

const List<UsertypeModel> usertypes = [
  UsertypeModel(
    usertype: "Subscriber",
    description: "Purchase data, airtime and pay bills for just yourself",
  ),
  UsertypeModel(
    usertype: "Reseller",
    description:
        "Purchase data, airtime and pay bills for others at a discounted price",
  ),
];
