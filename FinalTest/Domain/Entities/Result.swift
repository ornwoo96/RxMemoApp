//
//  Result.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/30.
//

import Foundation

struct ResultName: Codable {
    var apiNum: ResultResponse
    
    private enum CodingKeys: String, CodingKey {
        case apiNum = "I2790"
    }
}

struct ResultResponse: Codable {
    var totalCount: String?
    var row: [Result]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case row = "row"
    }
}

struct Result: Codable {
    var num: String?
    var foodCd: String?
    var regionName: String?
    var harvestMonth: String?
    var areaCode: String?
    var harvestMonthCode: String?
    var groupName: String?
    var foodName: String?
    var researchYear: String?
    var makerName: String?
    var subRefName: String?
    var servingSize: String?
    var calorie: String?
    var carbohydrate: String?
    var protein: String?
    var fat: String?
    var sugar: String?
    var sodium: String?
    var cholesterol: String?
    var saturatedFattyAcid: String?
    var transFat: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case num = "NUM"
        case foodCd = "FOOD_CD"
        case regionName = "SAMPLING_REGION_NAME"
        case harvestMonth = "SAMPLING_MONTH_NAME"
        case areaCode = "SAMPLING_REGION_CD"
        case harvestMonthCode = "SAMPLING_MONTH_CD"
        case groupName = "GROUP_NAME"
        case foodName = "DESC_KOR"
        case researchYear = "RESEARCH_YEAR"
        case makerName = "MAKER_NAME"
        case subRefName = "SUB_REF_NAME"
        case servingSize = "SERVING_SIZE"
        case calorie = "NUTR_CONT1"
        case carbohydrate = "NUTR_CONT2"
        case protein = "NUTR_CONT3"
        case fat = "NUTR_CONT4"
        case sugar = "NUTR_CONT5"
        case sodium = "NUTR_CONT6"
        case cholesterol = "NUTR_CONT7"
        case saturatedFattyAcid = "NUTR_CONT8"
        case transFat = "NUTR_CONT9"
    }
}


// 786707ec222c40daa0a7 -> 인증키

// https://openapi.foodsafetykorea.go.kr/api/786707ec222c40daa0a7/I2790/json/1/5/DESC_KOR=김치


//{"I2790":
//    {
//        "total_count":"457",
//        "row":
//        [{
//            "NUTR_CONT8":"0.3",
//            "NUTR_CONT9":"0",
//            "NUTR_CONT4":"2.8",
//            "NUTR_CONT5":"2.9",
//            "NUTR_CONT6":"1642.08",
//            "NUM":"1",
//            "NUTR_CONT7":"0",
//            "NUTR_CONT1":"89",
//            "NUTR_CONT2":"10.5",
//            "SUB_REF_NAME":"식약처(\u002715) 제3권",
//            "NUTR_CONT3":"5.4",
//            "RESEARCH_YEAR":"2019",
//            "MAKER_NAME":"",
//            "GROUP_NAME":"",
//            "SERVING_SIZE":"450",
//            "SAMPLING_REGION_NAME":"전국(대표)",
//            "SAMPLING_MONTH_CD":"AVG",
//            "SAMPLING_MONTH_NAME":"평균",
//            "DESC_KOR":"김치국",
//            "SAMPLING_REGION_CD":"ZZ",
//            "FOOD_CD":"D000032"
//
//        },{
//            "NUTR_CONT8":"0.04",
//            "NUTR_CONT9":"0",
//            "NUTR_CONT4":"0.33",
//            "NUTR_CONT5":"0.46",
//            "NUTR_CONT6":"339.9",
//            "NUM":"2",
//            "NUTR_CONT7":"1.03",
//            "NUTR_CONT1":"17.68",
//            "NUTR_CONT2":"2.61",
//            "SUB_REF_NAME":"식약처(\u002713) 제2권",
//            "NUTR_CONT3":"1.07",
//            "RESEARCH_YEAR":"2019",
//            "MAKER_NAME":"",
//            "GROUP_NAME":"",
//            "SERVING_SIZE":"50",
//            "SAMPLING_REGION_NAME":"전국(대표)",
//            "SAMPLING_MONTH_CD":"AVG",
//            "SAMPLING_MONTH_NAME":"평균",
//            "DESC_KOR":"열무얼갈이김치",
//            "SAMPLING_REGION_CD":"ZZ",
//            "FOOD_CD":"D000097"
//
//        },{
//            "NUTR_CONT8":"6.8","NUTR_CONT9":"0.1","NUTR_CONT4":"16.9","NUTR_CONT5":"1.2","NUTR_CONT6":"2531.6","NUM":"3","NUTR_CONT7":"45.65","NUTR_CONT1":"552","NUTR_CONT2":"86.2","SUB_REF_NAME":"식약처(\u002715) 제3권","NUTR_CONT3":"13.8","RESEARCH_YEAR":"2019","MAKER_NAME":"","GROUP_NAME":"","SERVING_SIZE":"650","SAMPLING_REGION_NAME":"전국(대표)","SAMPLING_MONTH_CD":"AVG","SAMPLING_MONTH_NAME":"평균","DESC_KOR":"김치라면","SAMPLING_REGION_CD":"ZZ","FOOD_CD":"D000139"
//
//        },{"NUTR_CONT8":"0.83","NUTR_CONT9":"0","NUTR_CONT4":"4.6","NUTR_CONT5":"2.13","NUTR_CONT6":"2874.6","NUM":"4","NUTR_CONT7":"14.13","NUTR_CONT1":"500.18","NUTR_CONT2":"99.14","SUB_REF_NAME":"식약처(\u002713) 제2권","NUTR_CONT3":"15.55","RESEARCH_YEAR":"2019","MAKER_NAME":"","GROUP_NAME":"","SERVING_SIZE":"800","SAMPLING_REGION_NAME":"전국(대표)","SAMPLING_MONTH_CD":"AVG","SAMPLING_MONTH_NAME":"평균","DESC_KOR":"김치우동","SAMPLING_REGION_CD":"ZZ","FOOD_CD":"D000140"},{"NUTR_CONT8":"1.1","NUTR_CONT9":"0","NUTR_CONT4":"4.8","NUTR_CONT5":"8.3","NUTR_CONT6":"2121.62","NUM":"5","NUTR_CONT7":"88.95","NUTR_CONT1":"302.53","NUTR_CONT2":"52","SUB_REF_NAME":"식약처(\u002716) 제4권","NUTR_CONT3":"12.9","RESEARCH_YEAR":"2019","MAKER_NAME":"","GROUP_NAME":"","SERVING_SIZE":"600","SAMPLING_REGION_NAME":"전국(대표)","SAMPLING_MONTH_CD":"AVG","SAMPLING_MONTH_NAME":"평균","DESC_KOR":"냉김치말이국수","SAMPLING_REGION_CD":"ZZ","FOOD_CD":"D000141"}],"RESULT":{"MSG":"정상처리되었습니다.","CODE":"INFO-000"}
//    }
//
//}
