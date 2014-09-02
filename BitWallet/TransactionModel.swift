//
//  TransactionModel.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/23/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import Foundation

struct Transaction {
    
    struct Input {
        let value: Int,
        addresses: Array<String>
        
        init(data: NSDictionary) {
            value = data["value"] as NSNumber
            addresses = data["addresses"] as Array<String>
        }
    }
    
    struct Output {
        let value: Int,
        addresses: Array<String>
        
        init(data: NSDictionary) {
            value = data["value"] as NSNumber
            addresses = data["addresses"] as Array<String>
        }
    }
    
    let rawData: NSDictionary,
        amount: Int,
        inputs: Array<Input> = [],
        outputs: Array<Output> = [],
        blockTime: NSDate?
    
    init(rawData data: NSDictionary) {
        rawData = data
        amount = rawData["amount"] as NSInteger
        
        let rawInputs = rawData["inputs"] as Array<NSDictionary>
        for rawInput in rawInputs {
            let input = Input(data: rawInput)
            inputs.append(input)
        }
        
        let rawOutputs = rawData["outputs"] as Array<NSDictionary>
        for rawOutput in rawOutputs {
            let output = Output(data: rawOutput)
            outputs.append(output)
        }

        
        
//        setBlockTime(rawData["block_time"] as? NSString)
    }
    
//    func setBlockTime(blockTimeString: String?) {
//        if blockTimeString != nil {
//            var dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
////            blockTime = dateFormatter.dateFromString(blockTimeString!)!
//    }
}

