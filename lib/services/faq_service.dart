import 'package:lcvd/models/prediction.dart';
import 'package:lcvd/models/question.dart';

class FaqService {
  static const Map<String, Map<String, String>> questionsCollection = {
    "Chilli - Healthy": {},
    "Chilli - Leaf Curl Virus": {
      "What is this disease?":
          "Chilli Leaf Curl Virus causes leaves to curl and become distorted, stunting plant growth. It is spread by insects like whiteflies and thrives in warm, humid conditions.",
      "What are the possible cures?":
          "There is no cure for Leaf Curl Virus. Control measures include removing infected plants, using insecticides to manage whiteflies, and planting virus-resistant varieties.",
      "What causes this disease?":
          "Leaf Curl Virus in chilli is caused by viral pathogens, spread by whiteflies that feed on sap. Warm, humid conditions promote the spread.",
      "What are the common symptoms?":
          "Symptoms include curled, twisted leaves, stunted growth, and yellowing. The plant’s productivity decreases as the disease spreads.",
      "What is the traditional diagnosis?":
          "Diagnosis is primarily visual, focusing on curled and distorted leaves. Further testing, such as PCR, can confirm the viral presence.",
      "What are the preventive measures?":
          "Preventive steps include planting resistant varieties, controlling whiteflies, maintaining garden hygiene, and improving air circulation by pruning."
    },
    "Tomato - Late Blight": {
      "What is this disease?":
          "Late Blight is a fungal disease affecting tomatoes, causing dark lesions on leaves and fruit, leading to rapid plant decay.",
      "What are the possible cures?":
          "No cure exists for infected plants. Fungicides may protect healthy plants, but early removal of infected plants is crucial to stop the spread.",
      "What causes this disease?":
          "Late Blight is caused by the fungus 'Phytophthora infestans', which thrives in cool, moist conditions and spreads rapidly.",
      "What are the common symptoms?":
          "Symptoms include dark, water-soaked lesions on leaves and fruits, wilting, and plant decay.",
      "What is the traditional diagnosis?":
          "Visual diagnosis involves identifying the characteristic dark lesions on leaves and fruit. Lab tests may confirm the fungal presence.",
      "What are the preventive measures?":
          "Preventive steps include using resistant varieties, applying fungicides, and removing infected plants early to stop spread."
    },
    "Tomato - Leaf Mold": {
      "What is this disease?":
          "Leaf Mold is a fungal disease affecting tomato leaves, reducing photosynthesis and potentially damaging the crop yield.",
      "What are the possible cures?":
          "Fungicides can control the spread if caught early. Removing affected leaves helps manage the disease.",
      "What causes this disease?":
          "Leaf Mold is caused by the fungus 'Passalora fulva', thriving in warm, humid environments with poor air circulation.",
      "What are the common symptoms?":
          "Symptoms include pale, moldy spots on the undersides of leaves, which eventually turn yellow and fall off.",
      "What is the traditional diagnosis?":
          "Visual diagnosis focuses on spotting mold patches on the leaves' undersides. Laboratory tests confirm fungal spores.",
      "What are the preventive measures?":
          "Good air circulation, avoiding overhead watering, and using fungicides can prevent Leaf Mold."
    },
    "Tomato - Mosaic Virus": {
      "What is this disease?":
          "Mosaic Virus causes mottled yellowing and distorted leaves, reducing tomato plant productivity.",
      "What are the possible cures?":
          "No cure exists once infected. Managing insect vectors and removing infected plants can help control the virus spread.",
      "What causes this disease?":
          "Mosaic Virus is caused by a viral infection spread by insects and contaminated tools.",
      "What are the common symptoms?":
          "Symptoms include mottled yellowing, stunted growth, and misshapen leaves and fruit.",
      "What is the traditional diagnosis?":
          "Diagnosis relies on visual symptoms such as leaf mottling. Lab tests like PCR may confirm the viral infection.",
      "What are the preventive measures?":
          "Preventive actions include using resistant varieties, controlling insects, and practicing good hygiene."
    },
    "Tomato - Septoria Leaf Spot": {
      "What is this disease?":
          "Septoria Leaf Spot is a fungal disease that affects tomato plants, causing leaf spotting and defoliation.",
      "What are the possible cures?":
          "Fungicides are effective if applied early. Removing affected leaves also helps in managing the disease.",
      "What causes this disease?":
          "It is caused by the fungus 'Septoria lycopersici', which thrives in warm, wet conditions.",
      "What are the common symptoms?":
          "Symptoms include circular spots with dark centers on leaves, leading to leaf drop.",
      "What is the traditional diagnosis?":
          "Visual diagnosis focuses on identifying characteristic spots on leaves. Further lab tests may confirm the fungus.",
      "What are the preventive measures?":
          "Prevention includes using resistant varieties, avoiding overhead watering, and removing infected leaves."
    },
    "Tomato - Target Spot": {
      "What is this disease?":
          "Target Spot is a fungal disease causing lesions on tomato leaves, stems, and fruit, which can lead to defoliation and crop loss.",
      "What are the possible cures?":
          "Applying fungicides early can control the disease. Removing affected leaves is recommended to stop its spread.",
      "What causes this disease?":
          "The disease is caused by the fungus 'Corynespora cassiicola', thriving in warm, moist environments.",
      "What are the common symptoms?":
          "Symptoms include brown, circular lesions with concentric rings on leaves, stems, and fruit.",
      "What is the traditional diagnosis?":
          "Visual diagnosis involves spotting the typical concentric lesions. Lab testing can confirm the fungal infection.",
      "What are the preventive measures?":
          "Prevention includes using fungicides, improving air circulation, and keeping leaves dry."
    },
    "Tomato - Two Spotted Spider Mite": {
      "What is this disease?":
          "This disease is caused by spider mites that suck sap from tomato plants, leading to discolored leaves and reduced productivity.",
      "What are the possible cures?":
          "Insecticides or biological controls like predatory mites can manage the infestation. Removing infected leaves also helps.",
      "What causes this disease?":
          "The damage is caused by two-spotted spider mites ('Tetranychus urticae'), which thrive in hot, dry conditions.",
      "What are the common symptoms?":
          "Symptoms include tiny yellow spots on leaves, leading to leaf drop and stunted growth.",
      "What is the traditional diagnosis?":
          "Visual inspection reveals fine webbing and tiny, discolored spots on leaves. Magnification may be needed to confirm mites.",
      "What are the preventive measures?":
          "Preventive steps include controlling mites with insecticides, biological controls, and improving humidity levels."
    },
    "Tomato - Yellow Leaf Curl Virus": {
      "What is this disease?":
          "Yellow Leaf Curl Virus stunts tomato plants and causes leaves to curl and yellow, drastically reducing yield.",
      "What are the possible cures?":
          "No cure exists, but controlling whiteflies, the main vector, and removing infected plants can prevent spread.",
      "What causes this disease?":
          "It is caused by a virus transmitted by whiteflies, which thrive in warm, humid climates.",
      "What are the common symptoms?":
          "Symptoms include yellowing, curled leaves, stunted growth, and poor fruit set.",
      "What is the traditional diagnosis?":
          "Visual symptoms include yellow, curled leaves. PCR tests can confirm the virus.",
      "What are the preventive measures?":
          "Prevention focuses on controlling whiteflies, planting resistant varieties, and maintaining garden hygiene."
    },
    "Pepper Bell - Bacterial Spot": {
      "What is this disease?":
          "Bacterial Spot causes small, water-soaked spots on pepper leaves and fruits, leading to defoliation and fruit loss.",
      "What are the possible cures?":
          "Copper-based bactericides can reduce bacterial spread. Removing infected plants is essential to stop transmission.",
      "What causes this disease?":
          "The disease is caused by the bacterium 'Xanthomonas campestris', spreading in warm, wet conditions.",
      "What are the common symptoms?":
          "Symptoms include small, water-soaked spots on leaves, stems, and fruit, leading to yellowing and leaf drop.",
      "What is the traditional diagnosis?":
          "Diagnosis is visual, focusing on small, dark spots on leaves and fruit. Lab tests may confirm the bacterium.",
      "What are the preventive measures?":
          "Preventive steps include using resistant varieties, copper-based bactericides, and proper sanitation."
    },
    "Pepper Bell - Healthy": {},
    "Potato - Early Blight": {
      "What is this disease?":
          "Early Blight is a fungal disease caused by *Alternaria solani*, affecting the leaves, stems, and fruit of potato plants. It leads to dark, concentric lesions, starting from older leaves and gradually spreading. This disease weakens the plant, reducing its ability to photosynthesize and causing premature defoliation, ultimately affecting crop yield and quality.",
      "What are the possible cures?":
          "No cure exists for plants already infected with Early Blight. However, disease management focuses on regular removal of infected plant material and applying fungicides to protect healthy parts. Fungicides like chlorothalonil or copper-based compounds can prevent the disease from spreading. Crop rotation and planting disease-resistant varieties can also help manage the disease.",
      "What causes this disease?":
          "Early Blight is caused by the fungus *Alternaria solani*. It spreads through airborne spores, particularly in warm, humid conditions. The fungus thrives on plant debris left on the soil surface, and infection is more likely when plants are stressed due to poor nutrition or drought. It typically begins on older leaves and can spread rapidly across the plant.",
      "What are the common symptoms?":
          "Common symptoms include dark, concentric rings on leaves that expand to form larger lesions. These spots often have a yellow halo around them. Affected leaves may wither and drop prematurely, reducing photosynthesis. Severe cases can lead to defoliation, affecting tuber development and crop yield. The disease can also affect stems and fruit.",
      "What is the traditional diagnosis?":
          "Early Blight is typically diagnosed through visual inspection. Characteristic lesions with concentric rings appear on older leaves, stems, and tubers. If necessary, laboratory tests like microscopic analysis or fungal cultures can confirm the presence of *Alternaria solani*. Polymerase chain reaction (PCR) tests may be used for more precise identification of the pathogen.",
      "What are the preventive measures?":
          "Preventive measures include practicing crop rotation, removing plant debris, and avoiding overhead irrigation to reduce leaf wetness. Fungicides can be applied preventively during favorable conditions. Growing resistant potato varieties and ensuring plants receive adequate nutrients can help minimize disease severity. Proper spacing improves air circulation, reducing humidity around the plants."
    },
    "Potato - Healthy": {},
    "Potato - Late Blight": {
      "What is this disease?":
          "Late Blight is a devastating disease caused by *Phytophthora infestans*, a water mold. It affects potato leaves, stems, and tubers, causing large, water-soaked lesions that turn brown and necrotic. Under favorable conditions, the disease can spread rapidly, resulting in severe crop loss.",
      "What are the possible cures?":
          "There is no cure for Late Blight once a plant is infected, but fungicides can protect healthy plants. Removing infected plants promptly and applying systemic fungicides like metalaxyl can help limit the spread. Resistant varieties and proper field sanitation are critical management strategies.",
      "What causes this disease?":
          "Late Blight is caused by *Phytophthora infestans*, a pathogen that spreads through water and wind-borne spores. Wet and cool conditions favor the development of the disease, which thrives in areas with prolonged leaf wetness. The pathogen can survive in infected plant debris or tubers.",
      "What are the common symptoms?":
          "Symptoms include large, dark brown or black lesions on leaves and stems, with a water-soaked appearance. White, fuzzy fungal growth may appear under moist conditions. Infected tubers develop brown, firm spots that penetrate deep into the flesh, making them unmarketable.",
      "What is the traditional diagnosis?":
          "Late Blight is traditionally diagnosed through visual symptoms like large, water-soaked lesions on leaves and stems, often accompanied by white, downy growth. In some cases, lab tests such as microscopic examination or DNA-based methods like PCR may be used to confirm *Phytophthora infestans* presence.",
      "What are the preventive measures?":
          "Preventive measures include using certified disease-free seed tubers, avoiding planting in poorly drained areas, and applying fungicides preventively during periods of high risk. Removing plant debris and tubers that harbor the pathogen is crucial. Resistant varieties and crop rotation can further reduce disease occurrence."
    },
    "Tomato - Bacterial Spot": {
      "What is this disease?":
          "Bacterial Spot is a serious disease caused by *Xanthomonas* bacteria, affecting tomato plants. It causes small, water-soaked spots on leaves, stems, and fruit, which can lead to defoliation and poor fruit quality. The disease thrives in warm, moist conditions.",
      "What are the possible cures?":
          "Once infected, plants cannot be cured of Bacterial Spot. Management involves removing affected plant parts, applying copper-based bactericides, and using disease-free seeds. Crop rotation and proper sanitation can help prevent future infections.",
      "What causes this disease?":
          "Bacterial Spot is caused by *Xanthomonas* bacteria. It spreads via water splashes, contaminated seeds, and tools. Warm, wet conditions favor the development of the disease. Insects and wind can also contribute to its transmission.",
      "What are the common symptoms?":
          "Symptoms include small, dark, water-soaked spots on leaves and fruits. These spots can merge, causing large areas of necrosis. In severe cases, leaves may fall off, exposing fruits to sunscald and reducing yield. Infected fruits develop blemishes, making them unsellable.",
      "What is the traditional diagnosis?":
          "Bacterial Spot is diagnosed through visual inspection of characteristic symptoms like small, water-soaked lesions. Laboratory analysis, including bacterial isolation or molecular tests like PCR, can confirm the presence of *Xanthomonas*. Leaf and fruit samples may also be cultured for accurate identification.",
      "What are the preventive measures?":
          "Preventive measures include planting disease-resistant varieties, using certified disease-free seeds, and maintaining good field hygiene. Avoid overhead irrigation to reduce leaf wetness. Copper-based bactericides can be used preventively, and proper crop rotation helps minimize bacterial buildup in the soil."
    },
    "Tomato - Early Blight": {
      "What is this disease?":
          "Early Blight is a fungal disease caused by *Alternaria solani*, affecting tomato leaves, stems, and fruits. It typically starts with small, dark lesions on older leaves, expanding into larger spots with concentric rings, leading to defoliation and reduced yield.",
      "What are the possible cures?":
          "There is no cure for infected plants, but fungicides like chlorothalonil can prevent further spread. Infected plant parts should be removed, and crop rotation can help. Growing resistant varieties and applying fungicides early in the growing season are effective management strategies.",
      "What causes this disease?":
          "Early Blight is caused by the fungus *Alternaria solani*, which thrives in warm, wet conditions. The fungus survives in plant debris and can be spread through wind, rain, or contaminated tools. Stress factors like poor nutrition can increase susceptibility to infection.",
      "What are the common symptoms?":
          "Symptoms include dark, concentric rings on leaves, stems, and fruits. Older leaves are typically affected first, eventually leading to defoliation. Fruit lesions appear sunken and can cause premature fruit drop, reducing marketable yield. Stem cankers may also develop.",
      "What is the traditional diagnosis?":
          "Traditional diagnosis involves identifying dark, concentric lesions on older leaves, stems, and fruits. In cases where visual inspection is insufficient, laboratory analysis may be used to isolate *Alternaria solani*. Microscopic examination or fungal cultures can provide a more definitive diagnosis.",
      "What are the preventive measures?":
          "Preventive measures include practicing crop rotation, removing plant debris, and applying fungicides preventively. Overhead irrigation should be avoided to reduce leaf wetness. Selecting disease-resistant varieties and ensuring good plant nutrition can further reduce the risk of infection."
    },
    "Tomato - Healthy": {}
  };

  static List<Question> getQuestions(Prediction prediction) {
    List<Question> result = [];

    Map<String, String> currentQuestions =
        questionsCollection[prediction.prediction ?? ""] ?? <String, String>{};

    currentQuestions.forEach(
      (key, value) {
        result.add(Question(expandedValue: value, headerValue: key));
      },
    );
    return result;
  }
}
