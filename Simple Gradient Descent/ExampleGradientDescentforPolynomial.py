# Gradient Descent for Polynomial f 

# Program uses Gradient Descent to find the critical points of the function f: R^2 ->R, (x,y) -> 2x^4 - x^2 -x^2 + y
# A key observation was made that simplified the descent program. The partial derivative with respect to y is 2y, meaning that we can fix y = 0, while we descend investigate x coordinates. 

import numpy as np 
import matplotlib.pyplot as plt 

def f(v): 
	# function in question 
	# v is a list of the x,y coordinates for the function f
	return 2*v[0]**4 -v[0]**3 -v[0]**2 +v[1]**2

def par_x_f(x):
	# partial derivative of x w.r.t x
	return 8*x**3 - 3*x**2 -2*x

def descent(init_val_x, step_size, iterations):
	# descent algorithm, incrementing the moments along the x axis from a set starting point
	# descent continues for a fixed number of iterations 

	next_term = 0
	previous = init_val_x
	its = []
	grad = []
	for i in range(iterations): 
		next_term = previous - step_size * par_x_f(previous)
		its.append(next_term)
		grad.append(par_x_f(previous))
		#if par_x_f(previous) < 10**(-14): 
		#	break
		previous = next_term
	return its, grad

def main(): 
	# critical points determined analytically for comparison
	crit_pts_x = [(3+np.sqrt(73))/16,(3-np.sqrt(73))/16,0]
	crit_pts_y = [0,0,0]

	# Running the descent with various starting points
	its, grad = descent(3,1/100,10000)
	its2, grad2 = descent(-3,1/100,10000)
	its3, grad3 = descent(0.0001,1/100,10000)
	its4, grad4 = descent(-0.0001,1/100,10000)

	# Plotting the results

	x = np.linspace(-1.5,1.5)
	y = np.linspace(-1.5,1.5)

	scat_x = np.array(its)
	scat_y = np.array([0]*len(its))

	scat_x2 = np.array(its2)
	scat_y2 = np.array([0]*len(its2))

	scat_x3 = np.array(its3)
	scat_y3 = np.array([0]*len(its3))

	scat_x4 = np.array(its4)
	scat_y4 = np.array([0]*len(its4))

	fig = plt.figure()
	ax1 = fig.add_subplot()

	xg, yg = np.meshgrid(x,y)
	ax1.contour(xg, yg, f([xg,yg]),100)

	ax1.scatter(scat_x,scat_y)
	ax1.scatter(scat_x2,scat_y2)
	ax1.scatter(scat_x3,scat_y3)
	ax1.scatter(scat_x4,scat_y4)
	ax1.scatter(crit_pts_x,crit_pts_y)

	# Printing the Results

	print('Descent 1 X-Coordinate:', scat_x[-1],'\n', 'Function Value:', f([scat_x[-1],0]),'\n', 'Error:', np.abs((3+np.sqrt(73))/16 - scat_x[-1]), '\n','Gradient:', grad[-1])
	print('%'*50)
	print('Descent 2 X-Coordinate:', scat_x2[-1],'\n', 'Function Value:', f([scat_x2[-1],0]),'\n', 'Error:', np.abs((3-np.sqrt(73))/16 - scat_x2[-1]), '\n','Gradient:', grad2[-1],3)
	print('%'*50)
	print('Descent 3 X-Coordinate:', scat_x3[-1],'\n', 'Function Value:', f([scat_x3[-1],0]),'\n', 'Error:', np.abs((3+np.sqrt(73))/16 - scat_x3[-1]), '\n','Gradient:', grad3[-1])
	print('%'*50)
	print('Descent 4 X-Coordinate:', scat_x4[-1],'\n', 'Function Value:', f([scat_x4[-1],0]),'\n', 'Error:', np.abs((3-np.sqrt(73))/16 - scat_x4[-1]), '\n','Gradient:', grad4[-1])
	print('%'*50)
	plt.show(block = True)

main()