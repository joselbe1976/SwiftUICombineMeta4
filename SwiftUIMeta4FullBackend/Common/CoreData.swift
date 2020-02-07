//
//  CoreData.swift
//  SwiftUIMeta4FullBackend
//
//  Created by Jose Luis on 07/02/2020.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import CoreData
import SwiftUI

#if os(iOS) || os(tvOS)
var ctx:NSManagedObjectContext {
    (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}
#elseif os(watchOS)
var ctx = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
#elseif os(OSX)
var ctx = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
#endif

func saveContext() {
    //ctx.perform {
        if ctx.hasChanges {
            do {
                try ctx.save()
            } catch {
                let nserror = error as NSError
                fatalError("No se ha podido grabar \(nserror)")
            }
        }
    //}
}



// ----------  Cache  functions Global Proyect ---------------------

func ExistCacheFile(idFile : String) -> Bool {

    let countFetch:NSFetchRequest<Cache> = Cache.fetchRequest()
    let predicate = NSPredicate(format: "%K = %@", #keyPath(Cache.id), idFile)
    countFetch.predicate = predicate
    let count = (try? ctx.count(for: countFetch)) ?? 0
    
    return (count > 0 ) ? true : false
}

func InsertCacheFile(idFile : String, data: Data){
    let newCache = Cache(context: ctx)
    newCache.id  = idFile
    newCache.data  = data
    saveContext()
 
}

func getCacheFile(idFile : String) -> Data?{
    
    var caches  = [Cache]()
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cache")
    let predicate = NSPredicate(format: "%K = %@", #keyPath(Cache.id), idFile)
    fetchRequest.predicate = predicate
    caches = try! ctx.fetch(fetchRequest) as! [Cache]

    // Then you can use your properties.

    if caches.count > 0 {
        return caches.first?.data
    }
    else{
        return Data()
    }

}


func deleteAllCacheRecords() {
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Cache")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

    do {
        try ctx.execute(deleteRequest)
        try ctx.save()
    } catch {
        print ("There was an error to delete")
    }
}
