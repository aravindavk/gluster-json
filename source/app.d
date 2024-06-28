import std.stdio;
import std.getopt;
import std.process;
import std.string;

import glustercli;

import commands;

int cliRouter(string[] args)
{
    try
    {
        if (args.nth(1) == "peer" && args.nth(2) == "probe")
            addPeer(args);
        // else if (args.nth(0) == "peer" && args.nth(1) == "detach")
        else if (
                 (args.nth(1) == "peer" || args.nth(1) == "pool") &&
                 (args.nth(2) == "status" || args.nth(2) == "list")
        )
            listPeers(args);
        else if (args.nth(1) == "volume" && args.nth(2) == "info")
        {
            if (args.nth(3) != "")
                getVolume(args);
            else
                listVolumes(args);
        }
        else if (args.nth(1) == "volume" && args.nth(2) == "status")
        {
            if (args.nth(3) != "all")
                getVolume(args, true);
            else
                listVolumes(args, true);
        }

        return 0;
    }
    catch (GlusterCommandException ex)
    {
        printError(ex.toString);
        return 1;
    }
}

int main(string[] args)
{
    // dfmt off
    // auto opts = getopt(

    // );
    // dfmt on

    GlusterCLISettings settings;

    auto hostname = execute(["hostname", "-f"]);
    settings.localhostAddress = environment.get("GLUSTER_PEER_ADDRESS", hostname.output.strip);

    initializeCli(settings);

    return cliRouter(args);
}
