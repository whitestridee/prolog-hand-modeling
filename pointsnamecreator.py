for k in range(1, 43):
    print("   read_files:tryloadpoint(Point" + str(k) + ", Interval, " + str(k) + ", Time),")


List = [
[
22,
23,
24
]
,
[
25,
26,
27
],
[
26,
27,
28
],
[
29,
30,
31
],
[
30,
31,
32
],
[
33,
34,
35
],
[
34,
35,
36
],
[
37,
38,
39
],
[
38,
39,
40]]
for k in range(len(List)):
    print("validatefinger(Point" + str(List[k][0]) + ", Point" + str(List[k][1]) + ", Point" + str(List[k][2]) + "),")

myinput = "Kurcina"
while myinput != "nene":
    myinput = input()
    print(str(int(myinput) + 21))