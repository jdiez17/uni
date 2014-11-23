#include <iostream>
#include <map>
#include <string>
#include <fstream>
#include <algorithm>
#include <sstream>

std::map<std::string, int> wordcount;

bool nonalpha(char c) {
    return !isalpha(c) && c != ' ';
}

int main(int argc, char** argv) {
    std::ifstream f("mobydick.txt");
    std::string contents;

    f.seekg(0, std::ios::end);
    contents.reserve(f.tellg());
    f.seekg(0, std::ios::beg);

    contents.assign((std::istreambuf_iterator<char>(f)), std::istreambuf_iterator<char>());

    std::transform(contents.begin(), contents.end(), contents.begin(), ::tolower);
    contents.erase(std::remove_if(contents.begin(), contents.end(), &nonalpha), contents.end());

    std::stringstream ss(contents);
    std::string buf;

    while(ss >> buf) {
        std::map<std::string, int>::iterator it = wordcount.find(buf);

        if(it != wordcount.end()) {
            it->second++;
        } else {
            it->second = 1;
        }
    }

    return 0;
}
