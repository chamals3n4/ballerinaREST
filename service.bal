import ballerina/http;

type Startup readonly & record {|
    string name;
    string founder;
|};

table<Startup> key(name) startups = table [
    //except other co-founders
    {
        name: "Airbnb",
        founder: "Brian Chesky"
    },
    {
        name: "Rooster",
        founder: "Bhanuka Harischandra"
    }
];

service / on new http:Listener(9090) {
    resource function get startups() returns Startup[] {
        return startups.toArray();
    }

    resource function post startups(Startup startup) returns Startup {
        startups.add(startup);
        return startup;
    }
}
