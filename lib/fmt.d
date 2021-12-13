/// Implementation of a FMT command

module fmt;

import std.stdio;
import std.conv;
import std.algorithm;

/**Authors: Kai D. Gonzalez
*/
string formatn(string src, string[] sdest) {
    return getRequests(src, sdest); 
}

string formatk(string src, string[string] sdest) { return KgetRequests(src, sdest); }

/**Implementation of FMT Evaluator & lexer */
string getRequests(string src, string[] dest) {
    int state = 0;
    string f;
    int req = 0;
    foreach (immutable c; src) {
        if (c == '{' && state == 0) state = 5;
        else if (c == '}' && state == 5) {state = 0; if (dest.length > req) { f ~= dest[req]; } else { writeln("fmt: can't find definition for variable (request " ~ to!string(req) ~ ")"); return "?"; } req += 1;}
        else { f ~= c; }
    }
    return f;
}

/**Implementation of FMT Evaluator & lexer */
string KgetRequests(string src, string[string] dest) {
    int state = 0;
    string f;
    int req = 0;
    string tmp;
    foreach (immutable c; src) {
        if (c == '{' && state == 0) state = 5;
        else if (c == '}' && state == 5) {state = 0; if (tmp in dest) { f ~= dest[tmp]; tmp = ""; } else { writeln("fmt: can't find key for name '" ~ tmp ~ " (request " ~ to!string(req) ~ ")"); tmp = ""; return "?"; } req += 1;}
        else { if (state == 5) { tmp ~= c; }else f ~= c; }
    }
    return f;
}
