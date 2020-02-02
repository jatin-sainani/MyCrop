import pandas.plotting as pdplt
import matplotlib.pylab as plt
import seaborn as sns
import subprocess
import pandas as pd
import numpy as np
import serial
from sklearn.tree import DecisionTreeClassifier, export_graphviz
from tkinter import *
import tkinter as Tk


class EnterInterface:
    def __init__(self, master):
        self.master = master
        master.title("Garden-Master Tool")
        master.minsize(width=1000, height=550)

        f1 = Frame(master, height=100, width=175)
        f1.pack_propagate(0)  # don't shrink
        f1.pack()
        f1.place(x=200, y=200)

        self.greet_button = Button(f1, text="Garden-Master", command=self.graph_menu)
        self.greet_button.config(activebackground='Green', relief='raised')
        self.greet_button.pack(fill=BOTH, expand=1)

        f3 = Frame(master, height=50, width=175)
        f3.pack_propagate(0)  # don't shrink
        f3.pack()
        f3.place(x=625, y=225)

        self.close_button = Button(f3, text="Close", command=master.quit)
        self.close_button.config(activebackground='Red')
        self.close_button.pack(fill=BOTH, expand=1)

    def graph_menu(self):
        menubar = Menu(root)
        menubar.add_command(label="Andrews Graph", activebackground='Light Green', command=self.display_andrews_graph)
        menubar.add_command(label="Regression Graph", activebackground='Light Green', command=self.regression_graph)
        menubar.add_command(label="Temperature Gradient", activebackground='Light Green', command=self.temp)
        menubar.add_command(label="FaceGrid", activebackground='Light Green', command=self.face)
        menubar.add_command(label="Humidity Gradient", activebackground='Light Green', command=self.humidity)
        menubar.add_command(label="Quit", activebackground='Light Green', command=root.quit)
        # display the menu
        root.config(menu=menubar)

    def display_andrews_graph(self):
        pdplt.andrews_curves(df, "output", ax=None)
        plt.show()

    def regression_graph(self):
        df = pd.read_csv("/home/scas/Documents/test_file2.csv", names=['humidity', 'temp', 'moisture', 'LDR', 'output'])
        sns.jointplot("moisture", "humidity", df, kind='reg')

    def temp(self):
        df = pd.read_csv("/home/scas/Documents/test_file2.csv", names=['humidity', 'temp', 'moisture', 'LDR', 'output'])
        g = sns.FacetGrid(df, col="output")
        g.map(sns.distplot, "temp")
        plt.show()

    def humidity(self):
        df = pd.read_csv("/home/scas/Documents/test_file2.csv", names=['humidity', 'temp', 'moisture', 'LDR', 'output'])
        g = sns.FacetGrid(df, col="output")
        g.map(sns.distplot, "humidity")
        plt.show()

    def face(self):
        df = pd.read_csv("/home/scas/Documents/test_file2.csv", names=['humidity', 'temp', 'moisture', 'LDR', 'output'])
        g = sns.FacetGrid(df, col="output")
        g.map(sns.regplot, "humidity", "temp")
        plt.xlim(0, 100)
        plt.ylim(0, 35)
        plt.show()


class greet_1:
    def __init__(self):
        def encode_target(df, target_column):
            df_mod = df.copy()
            targets = df_mod[target_column].unique()
            map_to_int = {name: n for n, name in enumerate(targets)}
            df_mod["Target"] = df_mod[target_column].replace(map_to_int)
            return df_mod, targets

        df2, targets = encode_target(df, "output")

        features = list(df2.columns[:4])
        y = df2["Target"]
        X = df2[features]
        dt = DecisionTreeClassifier(min_samples_split=20, random_state=99)
        dt.fit(X, y)
        # plt.figure()
        # plt.show()
        arduino_data = []
        # dt_test = pd.read_csv("test_this.csv", names=['humidity', 'temp', 'moisture', 'LDR']
        ser = serial.Serial('/dev/ttyACM0', baudrate=9600, timeout=1)

        def getValues():
            ser.write(b'g')
            arduino_data = ser.readline().decode('ascii')
            return arduino_data

        f5 = Frame(root, height=100, width=175)
        f5.pack_propagate(0)  # don't shrink
        f5.pack()
        f5.place(x=10, y=80)

        L1 = Label(f5, text="Enter 0 to proceed :")
        L1.pack()

        E1 = Entry(f5, bd=5)
        E1.pack()

        answer = E1.get()
        print(answer)

        if answer == 0:
            test_data = []
            test_data = getValues()
            myFile = open("/home/scas/Documents/test_data1.csv", 'w+')
            myFile.write(test_data)
            myFile.close()
            print("File Written")
            dt_test = pd.read_csv("/home/scas/Documents/test_data1.csv", names=['humidity', 'temp', 'moisture', 'LDR'])
            final_data = dt_test.head(1)
            type = dt.predict(final_data)
            # print dt.predict(x_test)
            if type == '[0]':
                print("dry")
            elif type == '[1]':
                print("Healthy")
            else:
                print("Unfavorable")


# reading the training data and storing it in pandas dataframe
df = pd.read_csv("/home/scas/Documents/test_file2.csv", names=['humidity', 'temp', 'moisture', 'LDR', 'output'])

# print df['output'].unique()

# sns.pairplot(df, hue="output", size=2)
# plt.show()


root = Tk.Tk()
background_image = Tk.PhotoImage(file="/home/scas/Downloads/hello (1).png")
background_label = Tk.Label(root, image=background_image)
background_label.place(x=0, y=0, relwidth=1, relheight=1)
my_gui = EnterInterface(root)
# root["bg"] = 'white'
root.mainloop()

'''
def visualize_tree(tree,feature_names):
    with open("dt.dot", 'w') as f:
        export_graphviz(tree, out_file=f, feature_names=feature_names)
    command = ["dot", "-Tpng", "dt.dot", "-o", "dt.png"]
    try:
        subprocess.check_call(command)
    except:
        exit("Could not run dot, ie graphviz, to "
             "produce visualization")
visualize_tree(dt, features)
'''