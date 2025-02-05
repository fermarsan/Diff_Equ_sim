
// PinModes: undef_mode=0, input, openCo, output, source


IoPin@ uPin  = component.getPin("u");
IoPin@ yPin = component.getPin("y");
IoPin@ clkPin  = component.getPin("CLK");

// coefficients
array<double> A = {0, 0, 0, 0};
array<double> B = {0, 0, 0, 0};

// input and output variables
array<double> u = {0, 0, 0, 0};
array<double> y = {0, 0, 0, 0};

void setup() // Executed at setScript()
{
    print("Differential Equation"); 
}

void reset() // Executed at Simulation start
{ 
    print("Differential Equation reset()"); 
    
    uPin.setPinMode( 1 );   // Input
    clkPin.setPinMode( 1 ); // Input
    yPin.setPinMode( 3 );   // Output
    yPin.setVoltage( 0 );

	clkPin.changeCallBack( element, true );		// clock callback function enabled	

}

void voltChanged()	// clock signal change
{	
	if( clkPin.getInpState() )	// if rising edge
	{
        // Implements the differential equation

        // step 1: rotate data vectors
        for( int i=3; i>0; i--)
        {
            u[i] = u[i-1];
            y[i] = y[i-1];
        } 

        // step 2: take a new input sample
        u[0] = uPin.getVoltage();

        // step 3: calculate the new output value (differential equation)
        double acc = 0;
        for( int i=1; i<4; i++)
        {
            acc += u[i]*B[i] - y[i]*A[i];
        }
        acc += u[0]*B[0];
        y[0] = acc/A[0];

        // step 4: set the output
        yPin.setVoltage( y[0] );
    }
}

void setA0(double in_A0)
{
	print("A[0] = " + in_A0);
	A[0] = in_A0;
}

double getA0()
{
	return A[0];
}

void setA1(double in_A1)
{
	print("A[1] = " + in_A1);
	A[1] = in_A1;
}

double getA1()
{
	return A[1];
}

void setA2(double in_A2)
{
	print("A[2] = " + in_A2);
	A[2] = in_A2;
}

double getA2()
{
	return A[2];
}

void setA3(double in_A3)
{
	print("A[3] = " + in_A3);
	A[3] = in_A3;
}

double getA3()
{
	return A[3];
}

void setB0(double in_B0)
{
	print("B[0] = " + in_B0);
	B[0] = in_B0;
}

double getB0()
{
	return B[0];
}

void setB1(double in_B1)
{
	print("B[1] = " + in_B1);
	B[1] = in_B1;
}

double getB1()
{
	return B[1];
}

void setB2(double in_B2)
{
	print("B[2] = " + in_B2);
	B[2] = in_B2;
}

double getB2()
{
	return B[2];
}

void setB3(double in_B3)
{
	print("B[3] = " + in_B3);
	B[3] = in_B3;
}

double getB3()
{
	return B[3];
}
