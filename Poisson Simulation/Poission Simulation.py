#Simulation of a poisson random variable 
#1. Set X = 0 and T = 0.
#2. Generate U uniform (0, 1) and let Y = −(1/λ) log(1 − U).
#3. Set T = T + Y .
#4. If T > 1, output X;
#5. else set X = X + 1 and go to step 2.
import numpy as np
import matplotlib.pyplot as plt 
def main():
	smpl = 10000
	lda = 10
	dist = []
	ys = []
	setzero = True
	for i in range(smpl): 
		if setzero == True: 
			T = 0 
			X = 0
		U = np.random.uniform(0,1)
		Y = (-1/lda)*np.log(1-U)
		T = T + Y 
		ys.append(Y)
		if T > 1: 
			dist.append(X)
			setzero = True
		else: 
			X = X + 1
			setzero = False


	plt.hist(dist)
	plt.show(block = True)
main()

