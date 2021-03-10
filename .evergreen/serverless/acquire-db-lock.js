const MAX_ATTEMPTS = 10

const conn = new Mongo(mongodbUri)
const db = conn.getDB("testing_meta")

const lockGuard = {
    'idle': false,
    'project': project,
    'author': author,
    'createdAt': ISODate(createdAt),
    'taskId': taskId,
}

let attempts = 0;
while (db.status.findOneAndReplace({ 'idle': true }, lockGuard) == null) {
    attempts++;
    print("DB locked, waiting for 30s then trying again (attempt #" + attempts + ")")

    if (attempts >= MAX_ATTEMPTS) {
        print("DB still locked after " + attempts + " attempts, giving up")
        print("Current lock guard details: ")
        printjson(db.status.findOne())
        quit(1)
    }
    sleep(1000)
}

print("Lock acquired")
