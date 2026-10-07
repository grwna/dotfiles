#include <bits/stdc++.h>
using namespace std;

// ------------------- Fast I/O -------------------
#define CP               ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);

// ------------------- Data Types -------------------
#define int              long long
#define pii              pair<int, int>
#define vi               vector<int>
#define vvi              vector<vector<int>>
#define vpii             vector<pair<int, int>>

// ------------------- Constants -------------------
const int INF            = 1e18;
const int MOD            = 1e9 + 7;
const int MOD2           = 998244353;
const double EPS         = 1e-9;

// --- Grid Directions (R, L, D, U, and Diagonals) ---
const int dx[8] = {0, 0, 1, -1, 1, -1, 1, -1};
const int dy[8] = {1, -1, 0, 0, 1, -1, -1, 1};

// ------------------- Macros -------------------
#define fi               first
#define se               second
#define pb               push_back
#define eb               emplace_back
#define sz(x)            (int)(x).size()
#define All(v)           v.begin(), v.end()
#define AllR(v)          v.rbegin(), v.rend()

// ------------------- Loops -------------------
#define FOR(i, a, b)     for (int i = (a); i < (b); ++i)
#define ROF(i, a, b)     for (int i = (a); i >= (b); --i)
#define REP(i, n)        FOR(i, 0, n)
#define EACH(x, a)       for (auto& x : a)

// ------------------- Bitwise -------------------
#define popcnt(x)        __builtin_popcountll(x)
#define clz(x)           __builtin_clzll(x) // count leading zeros
#define ctz(x)           __builtin_ctzll(x) // count trailing zeros

// ------------------- Utility Functions -------------------
template<class T> bool chmin(T& a, const T& b) { return b < a ? a = b, 1 : 0; }
template<class T> bool chmax(T& a, const T& b) { return a < b ? a = b, 1 : 0; }
int gcd(int a, int b) { return b == 0 ? a : gcd(b, a % b); }
int lcm(int a, int b) { return a / gcd(a, b) * b; }

// ------------------- Outputs -------------------
#define YES              cout << "YES\n"
#define NO               cout << "NO\n"
#define Yes              cout << "Yes\n"
#define No               cout << "No\n"

// ------------------- Debugging -------------------
#ifndef ONLINE_JUDGE
#define db(x)            cerr << #x << " -> " << x << '\n'
#else
#define db(x)
#endif

// =================== SOLUTION ===================

void solve() {
    // Write your solution here
    
}

signed main() {
    CP;
    
    // Uncomment if using local file I/O
    // freopen("input.txt", "r", stdin);
    // freopen("output.txt", "w", stdout);

    int t = 1;
    cin >> t; // Comment out if there is only 1 test case
    while (t--) {
        solve();
    }
    
    return 0;
}

