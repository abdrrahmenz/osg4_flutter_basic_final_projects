
class CardModel {
  String id;
  String name;
  String type;
  String desc;
  String race;
  String archetype;
  List<CardSet> cardSets;
  List<CardImage> cardImages;
  CardPrices cardPrices;
  String atk;
  String def;
  String level;
  String attribute;

  CardModel({
    this.id,
    this.name,
    this.type,
    this.desc,
    this.race,
    this.archetype,
    this.cardSets,
    this.cardImages,
    this.cardPrices,
    this.atk,
    this.def,
    this.level,
    this.attribute,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => new CardModel(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    desc: json["desc"],
    race: json["race"],
    archetype: json["archetype"] == null ? null : json["archetype"],
    cardSets: json["card_sets"] == null ? null : new List<CardSet>.from(json["card_sets"].map((x) => CardSet.fromJson(x))),
    cardImages: new List<CardImage>.from(json["card_images"].map((x) => CardImage.fromJson(x))),
    cardPrices: CardPrices.fromJson(json["card_prices"]),
    atk: json["atk"] == null ? null : json["atk"],
    def: json["def"] == null ? null : json["def"],
    level: json["level"] == null ? null : json["level"],
    attribute: json["attribute"] == null ? null : json["attribute"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "desc": desc,
    "race": race,
    "archetype": archetype == null ? null : archetype,
    "card_sets": cardSets == null ? null : new List<dynamic>.from(cardSets.map((x) => x.toJson())),
    "card_images": new List<dynamic>.from(cardImages.map((x) => x.toJson())),
    "card_prices": cardPrices.toJson(),
    "atk": atk == null ? null : atk,
    "def": def == null ? null : def,
    "level": level == null ? null : level,
    "attribute": attribute == null ? null : attribute,
  };
}

class CardImage {
  String id;
  String imageUrl;
  String imageUrlSmall;

  CardImage({
    this.id,
    this.imageUrl,
    this.imageUrlSmall,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) => new CardImage(
    id: json["id"],
    imageUrl: json["image_url"],
    imageUrlSmall: json["image_url_small"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "image_url_small": imageUrlSmall,
  };
}

class CardPrices {
  String cardmarketPrice;
  String tcgplayerPrice;
  String ebayPrice;
  String amazonPrice;

  CardPrices({
    this.cardmarketPrice,
    this.tcgplayerPrice,
    this.ebayPrice,
    this.amazonPrice,
  });

  factory CardPrices.fromJson(Map<String, dynamic> json) => new CardPrices(
    cardmarketPrice: json["cardmarket_price"],
    tcgplayerPrice: json["tcgplayer_price"],
    ebayPrice: json["ebay_price"],
    amazonPrice: json["amazon_price"],
  );

  Map<String, dynamic> toJson() => {
    "cardmarket_price": cardmarketPrice,
    "tcgplayer_price": tcgplayerPrice,
    "ebay_price": ebayPrice,
    "amazon_price": amazonPrice,
  };
}

class CardSet {
  String setName;
  String setCode;
  SetRarity setRarity;
  String setPrice;

  CardSet({
    this.setName,
    this.setCode,
    this.setRarity,
    this.setPrice,
  });

  factory CardSet.fromJson(Map<String, dynamic> json) => new CardSet(
    setName: json["set_name"],
    setCode: json["set_code"],
    setRarity: setRarityValues.map[json["set_rarity"]],
    setPrice: json["set_price"],
  );

  Map<String, dynamic> toJson() => {
    "set_name": setName,
    "set_code": setCode,
    "set_rarity": setRarityValues.reverse[setRarity],
    "set_price": setPrice,
  };
}

enum SetRarity { COMMON, SUPER_RARE, SHORT_PRINT, DUEL_TERMINAL_NORMAL_PARALLEL }

final setRarityValues = new EnumValues({
  "Common": SetRarity.COMMON,
  "Duel Terminal Normal Parallel ": SetRarity.DUEL_TERMINAL_NORMAL_PARALLEL,
  "Short Print": SetRarity.SHORT_PRINT,
  "Super Rare": SetRarity.SUPER_RARE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
