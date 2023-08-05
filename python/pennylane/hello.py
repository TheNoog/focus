# https://medium.com/@majeea81/pennylane-qml-hello-world-qubit-rotation-f691a0b51a35
import pennylane as qml
from pennylane import numpy as np  # When constructing a hybrid quantum/classical computational model with PennyLane, it is important to always import NumPy from PennyLane, not the standard NumPy!

# Rotate a qubit

# Create a device with one qubit.
dev1 = qml.device("default.qubit", wires=1)

# Construct the Q node
@qml.qnode(dev1)
def circuit(params):
    qml.RX(params[0], wires=0)
    qml.RY(params[1], wires=0)
    return qml.expval(qml.PauliZ(0))

# Evaluate and call the function with values
print(circuit([0.54, 0.12]))