# Simple Image Compression Using SVD for BW Photo


import numpy as np 
from PIL import Image
import matplotlib.pyplot as plt


class photo: 

	def __init__(self, image_path): 
		self.img = np.float64(np.array(Image.open(image_path))[..., 0])
		self.rank = np.linalg.matrix_rank(self.img)
		self.U, self.s, self.V = np.linalg.svd(self.img)
		self.s = self.s.tolist()
		self.s = [float(i)/max(self.s) for i in self.s]
		
	def compress_image(self, tolerance): 
		tol = tolerance
		s = []
		for i in range(len(self.s)): 
			if self.s[i] < tol: 
				s = self.s[:i]
				break
			else: 
				pass
		print("S",s)
		
		s_pivot = len(s)
		print("Pivot",s_pivot)

		# create pivot matrix 

		S = np.zeros((s_pivot,s_pivot))
		for i in range(s_pivot):
			S[i,i] = self.s[i]

		U_pivot = self.U[:,:s_pivot]

		print("U Pivot", U_pivot)
		
		V_pivot = self.V[:s_pivot, :]

		print("V Pivot", V_pivot)

		# recombine pivoted matrices 

		img_tilde = np.zeros((U_pivot.shape[0], V_pivot.shape[1]))
		for i in range(s_pivot):
			a= U_pivot[:,i]
			b= V_pivot[i,:]
			img_tilde += s[i]*(np.outer(a,b))
		
		return img_tilde

		
	def show_image(self,tolerance): 
		if tolerance > 0:
			plt.imshow(self.compress_image(tolerance), cmap = 'gray')
			plt.show()
		else: 
			plt.imshow(self.img, cmap = 'gray')
			plt.show()
