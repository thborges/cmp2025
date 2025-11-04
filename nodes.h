
#include<vector>
#include<string>

extern int yylineno;

using namespace std;

class Node {
protected:
    vector<Node*> children;
    int lineno;

public:
    Node() {
        lineno = yylineno;
    }

    int getLineNo() {
        return lineno;
    }

    void append(Node *n) {
        children.push_back(n);
    }
};

class Load: public Node {
protected:
    string name;
public:
    Load(string name) {
        this->name = name;
    }
};

class Store: public Node {
protected:
    string name;
public:
    Store(string name) {
        this->name = name;
    }
};

class ConstInteger: public Node {
protected:
    int value;
public:
    ConstInteger(int value) {
        this->value = value;
    }
};

class ConstDouble: public Node {
protected:
    double value;
public:
    ConstDouble(double value) {
        this->value = value;
    }
};

class BinaryOp: public Node {
protected:
    char oper;
public:
    BinaryOp(Node *left, char oper, Node *right) {
        this->oper = oper;
        this->append(left);
        this->append(right);
    }
};

