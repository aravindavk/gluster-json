import std.stdio;

import glustercli;
import vibe.data.json;
import core.exception : ArrayIndexError;

GlusterCLI cli;

void initializeCli(GlusterCLISettings settings)
{
    cli = new GlusterCLI(settings);
}

string nth(string[] args, int idx)
{
    try
        return args[idx];
    catch (ArrayIndexError)
        return "";
}

void printOk()
{
    writeln("{\"ok\": true}");
}

void printError(string message)
{
    writeln(serializeToJsonString(["error": message]));
}

void printJson(T)(T data)
{
    writeln(serializeToJsonString(data));
}

void addPeer(string[] args)
{
    string address = args.nth(3);
    cli.addPeer(address);
    printOk;
}

void listPeers(string[] args)
{
    cli.listPeers.printJson;
}

void getVolume(string[] args, bool status = false)
{
    return cli.getVolume(args.nth(3), status).printJson;
}

void listVolumes(string[] args, bool status = false)
{
    return cli.listVolumes(status).printJson;
}
