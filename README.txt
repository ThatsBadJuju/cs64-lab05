1) 
What my secret formula file is doing is:
My program first initializes all the values needed (krabby, a, b, c_arr, m_arr), then jumps to the first function, secret_formula_apply.
- Secret_formula_apply multiplies a0 and a1, and jumps to a loop that multiplies the result by itself 7 times. Then, it takes the mod 33 of that answer via the div instruction, and inserts it into c_array.

Next, the program returns back to where it left off in main_loop, and jumps to the next function, secret_formula_remove, taking values from c_arr[i].
- Secret_formula_remove multiplies a0 and a1, and jumps to a loop that multiplies the result by itself 3 times. Then, it takes the mod 33 of that answer via the div instruction.
- Secret_formula_remove reverses the encryption done by Secret_formula_apply, and plugs the result into m_arr[i].

Now that one iteration of main_loop has ended, we jump back to the start of main_loop to perform the previous actions a total of 10 times.
Finally, we print out c_arr and m_arr in two separate loops.


i) Yes, this is true:
c = secret_formula_apply(u[i]) = [9, 14, 1]
f = secret_formula_apply(t[i]) = [28, 9, 21]
c*f = [252, 126, 21]

u[i] * t[i]           = [21, 15, 21]
s_f_remove(c[i]*f[i]) = [21, 15, 21]


ii) No, this is false:
c = secret_formula_apply(u[i]) = [9, 14, 1]
f = secret_formula_apply(t[i]) = [28, 9, 21]
c+f = [37, 23, 22]

u[i] + t[i]           = [21, 15, 21]
s_f_remove(c[i]+f[i]) = [31, 9, 21]
