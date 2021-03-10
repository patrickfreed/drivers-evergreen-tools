const conn = new Mongo(mongodbUri)
const db = conn.getDB("testing_meta")

if (db.status.findOneAndReplace({ 'taskId': taskId }, { 'idle': true }) == null) {
    print("Could not find lock guard")
    print("Current lock status: ")
    printjson(db.status.findOne())
    quit(1)
}
print("Lock released")
