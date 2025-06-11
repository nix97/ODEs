![License](https://img.shields.io/github/license/nix97/odes)
![Issues](https://img.shields.io/github/issues/nix97/odes)
![Stars](https://img.shields.io/github/stars/nix97/odes)
![Numerical Methods](https://img.shields.io/badge/ODEs-Runge--Kutta-blue)
![language](https://img.shields.io/badge/language-Python-blue.svg)
![Lazarus](https://img.shields.io/badge/Built%20with-Lazarus-blue?logo=pascal)
![Language](https://img.shields.io/badge/Language-C%23-239120?logo=c-sharp&logoColor=white)
![Delphi](https://img.shields.io/badge/Built%20with-Delphi-red?logo=pascal)
![GitHub release downloads](https://img.shields.io/github/downloads/nix97/ODEs/latest/total)

## ODEs
### To Solve Ordinary Differential Equations(ODEs) using Numerical methods.
<br>
<br>

**1. System of Ordinary Differential Equation using Runge-Kutta fourth-order formula(RK4)**

Solving of First-Order Two Differential Equation Y'(t)=F(t,x,y) and X'(t)=F(t,x,y) IVP(Initial Value Problem).<br>
Source code in C#.
<br>
<br>
**2. Third-Order Differential Equation**

Using Runge-Kutta fourth-order formula(RK4)
Diff equation Y'''(t)=F(t,y,y',y'') use IVP(Initial Value Problem).<br>
Source code in C#.
<br>
<br>
**3.Linear Shooting Method**

To approximate the solution of the boundary value problem (bvp) x '' = p(t) x'(t) + q(t) x(t) + r(t) with x(a) = alpha and x(b) = beta over the interval [a, b], subinterval M by using the Runge-Kutta method of order 4.<br>
Source code in Lazarus/pascal.
<br>
<br>
**4. Second-order ODE Solver using Runge-Kutta-Fehlberg (RKF45)**

To solving initial value problem (ivp) second-order Ordinary Differential Equation(ODE) using Runge-Kutta-Fehlberg formula (RKF45). This formula got advantages than the RK4 classic, RKF45 have Error Estimation. In this python project, use math parser pymep, so we can input equation at runtime.
``` python
from pymep.realParser import eval
# e.g. slope g1
var = {"x": x[k], "y": Yk[k], "z":
      Yk_dash[k]}
g1 = h*eval(DiffEquation, var)
```
<br>

**5. ODEs Solver**

First-Order Ordinary Differential Equation (ivp) using Runge-Kutta 4th Order(RK4) method.
To approximate the solution of the initial value problem (ivp) y ' =f(x,y) with y(a)=yo over [a,b] and subinterval M.<br>
Source code in Delphi.
<br><br>

**6. Fourth-Order ODEs Solver**

Fourth-Order Ordinary Differential Equation (ivp) using Runge-Kutta 4th Order(RK4) method.
To approximate the solution of the initial value problem (ivp) <br>
y '''' =f(t,y,y',y'',y''') with initial condition y(t0), y'(t0), y''(t0) & y'''(t0) known as starting points, over [a,b] and subinterval M.
As the result we got values y,y',y'' and y'''(plot in graph). <br>
Source code in Lazarus.
<br><br>

**7. System of Third-Order ODEs Solver**

System of Third-Order Ordinary Differential Equation (ivp) using Runge-Kutta 4th Order(RK4) method.
To approximate the solution of the initial value problem (ivp) 
   <br>
   <p>&nbsp&nbsp&nbsp x'''= f(t,x,y,z,x',y',z',x'',y'',z'')</p>
   <p>&nbsp&nbsp&nbsp y'''= g(t,x,y,z,x',y',z',x'',y'',z'')</p>
   <p>&nbsp&nbsp&nbsp z'''= h(t,x,y,z,x',y',z',x'',y'',z'')</p>
   
with initial condition  x(t0), y(t0), z(t0), x'(t0), y'(t0), z'(t0)   x''(t0), y''(t0) and z''(t0) known, over [a,b] and subinterval M.
As the result we got values x,y,z,x',y',z',x'',y'' and z'' that ploted in the graph. <br>
Source code in Lazarus.
