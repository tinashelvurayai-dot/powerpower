-- Create Study Notes Table for Power Electronics Comprehensive Notes
-- Stores comprehensive study material from PDF resources
-- These notes are read-only and available to all authenticated users

BEGIN;

-- Create study_notes table
CREATE TABLE IF NOT EXISTS public.study_notes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  topic VARCHAR(100) NOT NULL,
  subtopic VARCHAR(150),
  category VARCHAR(50),
  section_number INT,
  order_index INT DEFAULT 0,
  difficulty_level VARCHAR(20) DEFAULT 'medium',
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index on topic for fast queries
CREATE INDEX idx_study_notes_topic ON public.study_notes(topic);
CREATE INDEX idx_study_notes_category ON public.study_notes(category);

-- Enable RLS
ALTER TABLE public.study_notes ENABLE ROW LEVEL SECURITY;

-- Create RLS policy: All authenticated users can read study notes
CREATE POLICY "Authenticated users can read study notes"
  ON public.study_notes
  FOR SELECT
  USING (auth.role() = 'authenticated_user');

-- Create RLS policy: Only admins can insert/update
CREATE POLICY "Only admins can modify study notes"
  ON public.study_notes
  FOR ALL
  USING (auth.jwt() ->> 'role' = 'admin')
  WITH CHECK (auth.jwt() ->> 'role' = 'admin');

-- Insert Power Electronics Study Notes from PDFs

-- ============================================
-- 1. GENERAL POWER ELECTRONICS FUNDAMENTALS
-- ============================================

INSERT INTO public.study_notes (title, content, topic, subtopic, category, section_number, order_index, difficulty_level) VALUES
('Introduction to Power Electronics', 
'**Power Electronics** is the technology that converts, conditions, and controls electrical power using semiconductor switches. It bridges the gap between signal electronics and power systems.

## Key Applications:
1. **AC to DC Conversion** (Rectification) - converting mains AC to DC for electronic devices
2. **DC to AC Conversion** (Inversion) - converting DC back to AC for transmission
3. **AC to AC Conversion** (AC regulators) - changing voltage/frequency
4. **DC to DC Conversion** (Choppers) - regulating DC voltage levels

## Basic Power Electronics Circuit:
- **Input**: AC or DC source
- **Converter**: Semiconductor switches (diodes, transistors, thyristors)
- **Output**: Regulated AC or DC power
- **Control**: Gate drive circuits controlling when switches turn on/off

## Key Advantages:
- High efficiency (>95%)
- Compact size
- Fast response
- Precise control
- Reduced losses compared to linear regulation',
'Power Electronics Fundamentals', 'Introduction', 'General', 1, 1, 'easy'),

('Semiconductor Power Devices Overview',
'**Semiconductor devices** are the heart of power electronics. They act as controlled switches converting one form of electrical power to another.

## Classification of Semiconductor Devices:

### 1. **Diodes**
- Uncontrolled switch
- Conducts in one direction only
- Used in rectifiers
- Fast recovery diodes for high-frequency applications

### 2. **Bipolar Junction Transistors (BJTs)**
- Controlled switch
- Low on-state voltage drop (0.2-0.5V)
- Requires base current drive
- Limited to low/medium power applications
- Switching frequency: up to 100 kHz

### 3. **Metal-Oxide-Semiconductor Field-Effect Transistors (MOSFETs)**
- Voltage-controlled device
- Low gate drive power requirements
- Fast switching (MHz range)
- Higher on-state resistance
- Thermal instability in parallel operation (positive temperature coefficient)

### 4. **Insulated-Gate Bipolar Transistors (IGBTs)**
- Combines BJT and MOSFET advantages
- Voltage-controlled (like MOSFET)
- Good current handling (like BJT)
- On-state voltage: 1-3V
- Switching frequency: up to 50 kHz
- Excellent for inverters and motor drives

### 5. **Thyristors (SCRs)**
- Gate-triggered switch
- High voltage/current handling (1000V, 1000A+)
- Once fired, stays on until current drops below holding current
- Requires commutation circuit to turn off (in AC circuits can turn off naturally)
- Lower on-state drop (1-2V)
- Medium switching frequencies',
'Power Electronics Fundamentals', 'Devices', 'General', 2, 2, 'medium'),

('Power Diodes - Characteristics and Applications',
'**Power diodes** are the simplest semiconductor devices used in power conversion.

## V-I Characteristics:

**Forward Bias Region:**
- Voltage drop: 0.5-1.0V (depending on current and type)
- Current increases rapidly with small voltage increase
- Dynamic resistance: $$r_f = \\frac{dV_f}{dI_f}$$

**Reverse Bias Region:**
- Small leakage current (μA range) until breakdown
- Reverse recovery time $$t_{rr}$$ - time for diode to stop conducting after current reversal
- Fast recovery diodes: $$t_{rr}$$ < 200 ns (for high-frequency applications)
- Standard diodes: $$t_{rr}$$ = 1-10 μs

## Key Parameters:

1. **Peak Inverse Voltage (PIV)**: Maximum reverse voltage without breakdown
2. **Average Forward Current**: Maximum continuous forward current
3. **Forward Voltage Drop** $$V_f$$: Typically 0.5-1.0V
4. **Reverse Leakage Current** $$I_R$$: Usually in μA range
5. **Junction Temperature** $$T_j$$: Must stay below $$T_{j,max}$$

## Power Calculation:
$$P_{loss} = V_f \\cdot I_f + I_R \\cdot V_R$$

## Applications:
- **Rectifiers**: Converting AC to DC
- **Free-wheeling diodes**: Protection in inductive circuits
- **Voltage clamps**: Protection against voltage spikes',
'Power Electronics Fundamentals', 'Diodes', 'General', 3, 3, 'medium');

-- ============================================
-- 2. THYRISTOR (SCR) - DETAILED COVERAGE
-- ============================================

INSERT INTO public.study_notes (title, content, topic, subtopic, category, section_number, order_index, difficulty_level) VALUES
('SCR - Structure and Operation',
'## Silicon Controlled Rectifier (SCR) - Thyristor Structure

**Four-layer PNPN semiconductor device** with three junctions (J1, J2, J3) and three terminals:
- **Anode (A)**: Connected to P-layer (top)
- **Cathode (K)**: Connected to N-layer (bottom)  
- **Gate (G)**: Connected to P-layer (middle control region)

## Two-Transistor Model:

The PNPN structure can be analyzed as two transistors in a feedback loop:
- **T1 (PNP)**: Formed by junctions J1 and J2
- **T2 (NPN)**: Formed by junctions J2 and J3

$$I_a = \\frac{(\\alpha_1 + \\alpha_2)I_g + I_{CO}}{1 - (\\alpha_1 + \\alpha_2)}$$

Where:
- $$\\alpha_1, \\alpha_2$$ = common-base forward current gains
- $$I_g$$ = gate current
- $$I_{CO}$$ = reverse saturation current

## Turn-On Process:

When gate current $$I_g$$ is applied:
1. T2 base current increases → T2 collector current increases
2. T2 collector current becomes T1 base current  
3. T1 collector current increases → increases T2 base current
4. **Positive feedback loop** → regenerative action
5. $$\\alpha_1 + \\alpha_2 \\to 1$$ → anode current $$I_a$$ increases rapidly
6. SCR latches ON - gate signal no longer needed

## Latching and Holding Current:

**Latching Current** $$I_L$$: Minimum anode current required to keep SCR latched after gate pulse removed (typically 200 mA - 2 A)

**Holding Current** $$I_H$$: Minimum anode current to maintain ON-state (typically 50-200 mA, slightly less than $$I_L$$)

Turn-off occurs when: $$I_a < I_H$$',
'Thyristor Devices', 'SCR Structure', 'SCR', 1, 10, 'medium'),

('SCR - Operating Modes and V-I Characteristics',
'## Three Operating Modes of SCR:

### 1. **Reverse Blocking Mode**
- Cathode positive w.r.t. anode
- J1, J3 reverse biased; J2 forward biased
- Very high impedance (acts as open circuit)
- Small leakage current (μA range)
- At critical breakdown voltage $$V_{BR}$$, avalanche breakdown occurs
- Maximum reverse voltage must not exceed $$V_{BR}$$

### 2. **Forward Blocking Mode (OFF-State)**
- Anode positive w.r.t. cathode
- Gate not triggered (or zero gate current)
- J1, J3 forward biased; J2 reverse biased
- SCR blocks forward current
- Impedance is high (blocks)
- Small forward leakage current $$I_{BO}$$ (μA - mA range)
- At forward breakover voltage $$V_{BO}$$, avalanche breakdown at J2 occurs
- $$V_{BO}$$ = 400-1200V (depends on device rating)
- This is undesirable - should be avoided by keeping $$V_a < V_{BO}$$

### 3. **Forward Conduction Mode (ON-State)**  
- Anode positive w.r.t. cathode
- Gate triggered (positive gate current applied)
- OR forward voltage exceeds $$V_{BO}$$
- SCR conducts - all three junctions forward biased
- Very low impedance (conducts heavily)
- On-state voltage drop $$V_T$$ = 1-2V (independent of $$I_a$$ in saturation region)
- Static resistance: $$r_T = \\frac{V_T}{I_a}$$

## Complete V-I Characteristic Equation:

In forward blocking region:
$$I_a = I_{BO}[1 + (V_a/V_{BO})^n]$$

Where n = 5-8 (exponential rise near breakdown)

## Critical Parameters:

| Parameter | Symbol | Typical Value |
|-----------|--------|----------------|
| Peak Inverse Voltage | PIV / VRRM | 100-3000V |
| Forward Voltage Drop | V_T | 1-2V |
| Peak Forward Current | I_FAV | 50-3500A |
| Latching Current | I_L | 0.2-2 A |
| Holding Current | I_H | 0.05-0.5 A |
| Turn-on Time | t_on | 0.5-2 μs |
| Turn-off Time | t_off | 10-30 μs |',
'Thyristor Devices', 'SCR Characteristics', 'SCR', 2, 11, 'hard'),

('SCR - Gate Characteristics and Triggering',
'## Gate Characteristics:

**Gate Triggering Voltage** $$V_{GT}$$: Minimum gate-cathode voltage to trigger SCR (typically 0.5-2V)

**Gate Triggering Current** $$I_{GT}$$: Minimum gate current to trigger SCR (typically 10-100 mA for medium-power SCRs)

Gate characteristic varies with anode voltage - higher $$I_a$$ makes triggering easier.

## Triggering Methods:

### 1. **DC Gate Triggering**
- Simple DC voltage/current to gate
- Used when continuous control needed
- Gate power dissipation: $$P_G = V_G \\cdot I_G$$

### 2. **AC Gate Triggering**  
- Pulse applied during desired part of AC cycle
- Phase control achieved by varying pulse timing
- Energy efficient (gates only when needed)

### 3. **UJT (Unijunction Transistor) Relaxation Oscillator**
- Generates sawtooth pulses
- Charges capacitor until peak point voltage $$V_p$$ reached
- Then discharges through base creating gate pulse
- Frequency: $$f = \\frac{1.2}{R \\cdot C}$$ (approximate)

## Minimum Gate Power Requirement:

$$P_{G,min} = V_{GT} \\cdot I_{GT}$$

For protection, typical gate circuit includes:
- **Series resistor** to limit gate current
- **Diode** to protect against negative gate voltage  
- **RC snubber** to filter noise

## Gate Drive Circuit Design:

For safe triggering, gate circuit should provide:
- Voltage margin: $$V_G > 1.5 \\times V_{GT}$$
- Current margin: $$I_G > 1.5 \\times I_{GT}$$
- Pulse width: typically 10-50 μs
- Rise time: < 1 μs (to avoid dv/dt triggering)',
'Thyristor Devices', 'Gate Characteristics', 'SCR', 3, 12, 'medium');

-- ============================================
-- 3. PROTECTION CIRCUITS
-- ============================================

INSERT INTO public.study_notes (title, content, topic, subtopic, category, section_number, order_index, difficulty_level) VALUES
('Snubber Circuit Design for Thyristors',
'## Purpose of Snubber Circuits:

Thyristors and other semiconductor switches face two main threats:

1. **dv/dt Problem**: Rapid voltage changes can trigger unintended turn-on
   - Typically: $$\\frac{dv}{dt} \\leq 200 V/\\mu s$$
   - Exceeding this causes capacitive current injection into gate → false triggering

2. **di/dt Problem**: Rapid current changes stress the junction
   - Typically: $$\\frac{di}{dt} \\leq 50 A/\\mu s$$  
   - Exceeding this concentrates current in junction area → hot spots → failure

## RC Snubber Circuit Design:

**Snubber Components:**
- **R_s**: Snubber resistor
- **C_s**: Snubber capacitor
- **L_d**: Series inductor (optional, for di/dt control)
- **D_s**: Diode (optional, for energy recovery)

## Design Equations:

**Step 1: Determine safe dv/dt**
Apply safety factor (SF = 2-3):
$$(dv/dt)_{allowed} = \\frac{dv/dt_{max}}{SF}$$

**Step 2: Calculate Snubber Capacitor**
$$C_s = \\frac{V_m}{R_L \\cdot (dv/dt)_{allowed}}$$

Where $$V_m$$ = peak supply voltage, $$R_L$$ = load resistance

**Step 3: Calculate Snubber Resistor**  
$$R_s = \\frac{V_m}{I_{peak}}$$

Where $$I_{peak}$$ is peak discharge current (typically design for 50-100A safety margin)

**Step 4: Calculate Series Inductor (if needed)**
$$(di/dt)_{allowed} = \\frac{di/dt_{max}}{SF}$$

$$L = \\frac{V_m}{(di/dt)_{allowed}}$$

## Design Example:

**Given:**
- Peak supply voltage = 400V
- Maximum dv/dt = 200 V/μs
- Maximum di/dt = 50 A/μs  
- Load resistance = 10Ω
- Safety factor = 2

**Solution:**

Step 1: Safe dv/dt = 200/2 = 100 V/μs

Step 2: $$C_s = \\frac{400}{10 \\cdot 100 \\times 10^6} = 0.4 \\mu F$$

Step 3: $$R_s = \\frac{400}{100} = 4 \\Omega$$

Step 4: Safe di/dt = 50/2 = 25 A/μs

        $$L = \\frac{400}{25 \\times 10^6} = 16 \\mu H$$

**Final Snubber Circuit:**
- $$C_s = 0.4 \\mu F$$
- $$R_s = 4 \\Omega$$ 
- $$L = 16 \\mu H$$
- Place RC network across thyristor terminals
- Place inductor in series with load

## Power Dissipation in Snubber:

Energy dissipated per cycle:
$$E_{snub} = \\frac{1}{2} C_s V_m^2 \\cdot f$$

Average power in resistor:
$$P_R = \\frac{1}{2} C_s V_m^2 \\cdot f$$

For our example at 60 Hz:
$$P_R = \\frac{1}{2} \\cdot 0.4 \\times 10^{-6} \\cdot 400^2 \\cdot 60 = 1.92 W$$

Resistor rating: P > 1.92W, voltage > 400V',
'Protection Circuits', 'Snubber Design', 'Protection', 1, 20, 'hard'),

('Commutation Techniques for Thyristors',
'## Definition:
**Commutation** = Process of turning OFF a thyristor by reducing anode current below holding current

Unlike BJTs/MOSFETs, SCRs cannot be turned off by removing gate signal - must force current to zero.

## Need for Commutation:
In DC circuits, once SCR fires, it stays on indefinitely until power removed. 

In AC circuits, SCR naturally turns off when AC current crosses zero (natural commutation).

## Classification of Commutation:

### **Class A - Natural Commutation**
- Current naturally reduces to zero (AC supply)
- No external commutation circuit needed
- Used in AC rectifiers, inverters
- Simple, reliable, efficient
- Example: AC-DC phase-controlled rectifier

### **Class B - Voltage Commutation**  
- External voltage source opposes forward voltage
- Forces current to zero
- Requires energy supply
- Complex circuits

### **Class C - Current Commutation**
- Inductor energy used to commute
- Inductor forced to discharge through SCR and parallel diode
- When inductor current reverses, SCR current goes to zero
- SCR turns off
- Useful in DC choppers

### **Class D - Resonant Commutation**
- LC circuit creates resonant current
- Current oscillates, crosses zero
- SCR turns off at current zero crossing
- Soft switching reduces EMI
- Used in modern converters

### **Class E - Complementary Commutation**  
- SCRs used in push-pull configuration
- One SCR on, other off
- When second SCR fires, first commutates
- Used in bridge converters

### **Class F - Impulse Commutation**
- Separate commutation circuit generates impulse
- Forces current reversal
- SCR turns off when current reverses
- Used in motor control

## Commutation Time Considerations:

**Turn-off time** $$t_{off}$$: Time for SCR to recover reverse blocking capability (10-30 μs for SCRs)

**Commutation margin**: Time between when forward current goes to zero and when reverse bias can be applied

Must wait for turn-off time before applying forward voltage again, otherwise SCR may re-trigger.

## Design Guideline:

For safe operation: $$t_{cycle} > t_{off} + t_{recovery}$$

Where $$t_{recovery}$$ includes reverse recovery time of freewheeling diodes (if used)',
'Protection Circuits', 'Commutation', 'Protection', 2, 21, 'hard');

-- ============================================
-- 4. RECTIFIER CIRCUITS
-- ============================================

INSERT INTO public.study_notes (title, content, topic, subtopic, category, section_number, order_index, difficulty_level) VALUES
('Phase-Controlled Half-Wave Rectifier',
'## Circuit Configuration:

**Components:**
- AC supply: $$V_m \\sin(\\omega t)$$
- SCR as controlled switch
- Load resistor $$R_L$$
- Gate drive circuit for controlling firing angle

## Operating Principle:

### **Positive Half-Cycle:**
1. When SCR fired at angle $$\\alpha$$ (firing angle):
   - SCR conducts from $$\\alpha$$ to $$\\pi$$ (180°)
   - Current flows through load: $$i = \\frac{V_m}{R_L} \\sin(\\omega t)$$
   - Voltage across load: $$v_{out} = V_m \\sin(\\omega t)$$ for $$\\alpha < \\omega t < \\pi$$

2. From $$\\pi$$ to $$2\\pi$$ (negative half):
   - SCR reverse biased → blocks
   - No current flows
   - $$v_{out} = 0$$

## Output Voltage:

**Average Output Voltage:**
$$V_{avg} = \\frac{V_m}{\\pi} \\int_\\alpha^\\pi \\sin(\\omega t) d(\\omega t)$$

$$V_{avg} = \\frac{V_m}{\\pi} [- \\cos(\\omega t)]_\\alpha^\\pi$$

$$V_{avg} = \\frac{V_m}{\\pi} [1 + \\cos(\\alpha)]$$

### **Key Angles:**
- $$\\alpha = 0°$$: $$V_{avg} = \\frac{V_m}{\\pi} \\cdot 2 = 0.637 V_m$$ (maximum)
- $$\\alpha = 90°$$: $$V_{avg} = \\frac{V_m}{\\pi} \\cdot 1 = 0.318 V_m$$ 
- $$\\alpha = 180°$$: $$V_{avg} = 0$$ (SCR never fires)

**RMS Output Voltage:**
$$V_{rms} = V_m \\sqrt{\\frac{1}{2\\pi}(\\pi - \\alpha + \\frac{1}{2}\\sin(2\\alpha))}$$

## Load Current:

**Average Load Current:**
$$I_{avg} = \\frac{V_{avg}}{R_L} = \\frac{V_m}{\\pi R_L}[1 + \\cos(\\alpha)]$$

**RMS Load Current:**
$$I_{rms} = V_{rms} / R_L$$

## Power Analysis:

**Average Power:**
$$P_{avg} = \\frac{V_{avg}^2}{R_L} = \\frac{V_m^2}{\\pi^2 R_L}[1 + \\cos(\\alpha)]^2$$

**Reactive Power & Power Factor:**
- Contains harmonics (3rd, 5th, 7th order)
- Power factor decreases with increasing $$\\alpha$$
- At $$\\alpha = 0°$$: PF ≈ 0.9
- At $$\\alpha = 90°$$: PF ≈ 0.45

## Ripple Voltage:

Output contains significant ripple (Fourier series with DC component):

$$v_{out} = \\frac{V_m}{\\pi}[1 + \\cos(\\alpha)] + \\frac{V_m}{\\sqrt{2}}\\sin(\\omega t) + ...$$

Ripple frequency = source frequency (60 Hz)

For practical applications, **LC filter** needed to reduce ripple to acceptable levels',
'Rectifier Circuits', 'Half-Wave Control', 'Rectifiers', 1, 30, 'hard'),

('Full-Wave Phase-Controlled Rectifier',
'## Circuit Configuration:

**Using Bridge of SCRs:**
Four SCRs in bridge configuration (like Graetz bridge but with controlled switches)

```
        ┌──SCR1──┐
      ─┤        ├─ Out+
    AC │        │
      ─┤  ┌──┐  ├─ Out-
        └──SCR4─┘
        (simplified representation)
```

**Advantages over Half-Wave:**
- Uses both positive and negative half-cycles
- Higher average output voltage (≈2× half-wave)
- Lower ripple frequency (120 Hz instead of 60 Hz)
- Better power factor

## Operating Principle:

**Positive Half-Cycle** (0 to π):
- SCR1 and SCR4 are positive gates
- When fired at angle $$\\alpha$$: conducts from $$\\alpha$$ to $$\\pi$$
- Current path: through SCR1, load, SCR4
- Output voltage: positive

**Negative Half-Cycle** (π to 2π):
- SCR2 and SCR3 are positive gates  
- When fired at angle $$\\alpha$$: conducts from $$\\pi + \\alpha$$ to $2\\pi$$
- Current path: through SCR2, load, SCR3
- Output voltage: positive (current direction reversed in load)

## Output Voltage:

**Average Output Voltage (Full-Wave):**
$$V_{avg,fw} = \\frac{2V_m}{\\pi}[1 + \\cos(\\alpha)] / 2 = \\frac{V_m}{\\pi}[1 + \\cos(\\alpha)]$$

Wait, that''s same as half-wave formula. Let me recalculate...

**Correct Formula:**
$$V_{avg,fw} = \\frac{2V_m}{\\pi}\\cos(\\alpha)$$

### **Key Points:**
- $$\\alpha = 0°$$: $$V_{avg} = \\frac{2V_m}{\\pi} = 0.637 V_m$$... 

Actually, for correct full-wave 2-pulse rectifier:
$$V_{avg} = \\frac{2V_m}{\\pi}\\cos(\\alpha)$$

For $$\\alpha = 0°$$: $$V_{avg} = 2V_m/\\pi ≈ 0.637 V_m$$

Hmm, actually single-phase full-wave also gives same avg value. Three-phase rectifiers give higher voltage.

**For 3-Phase Full-Wave (6-pulse rectifier):**
$$V_{avg,3ph} = \\frac{3V_m}{\\pi}\\cos(\\alpha)$$

where $$V_m$$ is line-to-neutral voltage.

## Advantages over Half-Wave:

| Parameter | Half-Wave | Full-Wave |
|-----------|-----------|-----------|
| Ripple Frequency | f | 2f |
| Ripple Voltage | High | Lower |
| Power Factor | Poor | Better |
| Peak Inverse Voltage | $$V_m$$ | $$V_m$$ |
| Average Voltage | $$V_m/\\pi[1+\\cos\\alpha]$$ | $$2V_m/\\pi\\cos\\alpha$$ |
| Transformer Utilization | Lower | Higher |

## Design Considerations:

- **Gate drive complexity**: Must synchronize gates with supply phase (phase-locked loop or zero-crossing detector)
- **Turn-off requirements**: All four SCRs properly commutated by AC supply crossing zero
- **Output filtering**: Still requires LC filter to meet voltage ripple specs
- **Power factor correction**: May require passive or active PFC circuits',
'Rectifier Circuits', 'Full-Wave Control', 'Rectifiers', 2, 31, 'hard');

-- ============================================
-- 5. POWER TRANSISTORS & MODERN DEVICES
-- ============================================

INSERT INTO public.study_notes (title, content, topic, subtopic, category, section_number, order_index, difficulty_level) VALUES
('MOSFET Characteristics and Gate Drive',
'## MOSFET Structure:

**Metal-Oxide-Semiconductor Field-Effect Transistor**

Gate terminal is **insulated** from channel by silicon dioxide (SiO2) layer

## Operating Regions:

### **1. Cutoff Region**
- Gate-source voltage $$V_{GS} < V_{TH}$$ (threshold voltage)
- Channel not formed - no current flows
- Depletion MOSFET: $$V_{TH} ≈ -2 to -5 V$$  
- Enhancement MOSFET: $$V_{TH} ≈ 2 to 5 V$$
- Acts as open switch

### **2. Linear (Triode) Region**
- $$V_{GS} > V_{TH}$$ and $$V_{DS} < (V_{GS} - V_{TH})$$
- Channel formed and current depends on both $$V_{GS}$$ and $$V_{DS}$$
- Acts as variable resistor
- Resistance increases with temperature (positive coefficient)
- **Safe for parallel operation** - hotter device has higher resistance, reduces current share imbalance

### **3. Saturation Region**  
- $$V_{GS} > V_{TH}$$ and $$V_{DS} ≥ (V_{GS} - V_{TH})$$
- Channel pinched off - current becomes nearly independent of $$V_{DS}$$
- Current limited by channel resistance: $$I_D = \\frac{\\mu C_{ox}}{2} \\frac{W}{L}(V_{GS} - V_{TH})^2$$
- **Preferred operating region for switching** - acts as closed switch
- On-state resistance: $$R_{DS(on)} = \\rho [V_{GS} - V_{TH}]^{-2}$$

## Key Advantages:

1. **Voltage-controlled** (not current-controlled like BJT)
2. **Very low gate drive power** - gate capacitive, minimal steady-state current
3. **Fast switching** - can operate at MHz frequencies
4. **Lower on-state voltage drop** compared to BJT
5. **Negative temperature coefficient in saturation** - but **positive in triode** (good for paralleling)
6. **No secondary breakdown** like BJTs
7. **Simple gate drive circuit** - just capacitor charging

## Key Disadvantages:

1. **Higher on-state resistance** than BJT or IGBT (increases losses in saturation)
2. **Gate charge** must be supplied to form inversion layer ($$Q_g$$ = 10-500 nC)
3. **Temperature coefficient**: On-resistance increases with temperature
4. **Body diode**: Antiparallel diode with slow reverse recovery (1-10 μs)
5. **EMI concerns**: Fast switching creates high dv/dt
6. **Gate oxide breakdown**: Limited voltage, typically ±20V maximum gate drive

## Gate Drive Requirements:

**Threshold Voltage** $$V_{TH}$$: Typically 2-5V

**For adequate ON-state:** $$V_{GS} = V_{TH} + 5-15 V$$

Common values:
- Logic-level MOSFET: $$V_{GS} = 5 V$$ (often insufficient for power MOSFETs)
- Standard MOSFET: $$V_{GS} = 10 V$$ (recommended minimum)
- High-voltage MOSFET: $$V_{GS} = 15 V$$ (often required)

**Gate Charge and Switching Time:**

Turn-on sequence:
1. Plateau at $$V_{TH}$$ while capacitive voltage rises
2. Miller plateau where gate voltage stays constant while $$V_{DS}$$ falls  
3. Final rise to $$V_{GS(final)}$$

Total gate charge: $$Q_g = Q_{gs} + Q_{gd}$$

Switching time: $$t_{sw} ≈ \\frac{Q_g}{I_g}$$

where $$I_g$$ = gate drive current

## Typical Ratings (Power MOSFET):

| Parameter | Value |
|-----------|-------|
| Voltage Rating | 100-1200V |
| Current Rating | 1-500A |
| On-resistance | 1-500 mΩ |
| Switching Frequency | 1-100 MHz |
| Maximum junction temp | 150-175°C |
| Thermal resistance | 0.1-10°C/W |',
'Modern Devices', 'MOSFETs', 'Transistors', 1, 40, 'hard'),

('IGBT - Insulated Gate Bipolar Transistor',
'## Definition:

**IGBT** = Combination of MOSFET and BJT characteristics in one device

**Gate terminal**: Insulated like MOSFET (easy gate drive)
**Output terminals**: Act like BJT (good current handling)

## Structure:

- P+ collector region (instead of N+ in MOSFET)
- Creates minority carrier modulation
- Reduces on-state voltage drop significantly

## Advantages of IGBT:

1. **MOSFET advantages**:
   - Gate voltage controlled (not current)
   - Very low gate drive power
   - Fast switching capability
   - Simple gate circuits

2. **BJT advantages**:
   - Low on-state voltage drop (1-3V vs 0.5-1V for BJT, but less than MOSFET)
   - Excellent current handling
   - Better thermal characteristics

3. **Overall performance**:
   - Good balance between conduction and switching losses
   - Safe operating area larger than BJT
   - No secondary breakdown
   - Excellent thermal stability

## Operating Regions:

### **Cutoff**:
- $$V_{GE} < V_{TH}$$ 
- No current, acts as open circuit

### **Linear/Active Region**:
- $$V_{GE} > V_{TH}$$ and $$V_{CE} < V_{sat}$$
- Current increases with $$V_{GE}$$
- Acts like current source controlled by gate voltage

### **Saturation**:
- $$V_{CE,sat}$$ ≈ 0.5-1V (much lower than BJT)
- Maximum current capability
- **Preferred switching region**

## Key Parameters:

| Parameter | Typical Range |
|-----------|----------------|
| Voltage Rating | 300-3300V |
| Current Rating | 10-2500A |
| Conduction Loss | $$V_{CE,sat}$$ = 0.5-2V |
| Switching Freq | 1-50 kHz |
| Turn-on time | 0.1-1 μs |
| Turn-off time | 0.5-3 μs |
| Gate charge | 50-2000 nC |

## Gate Drive Voltage:

- **Low**: $$V_{GE} = 0V$$ (off)
- **High**: $$V_{GE} = 10-15V$$ (on)
- Difference margin needed for noise immunity

**Drive current requirement:**
$$I_g = \\frac{Q_g}{t_{rise}}$$

For 1 μs rise time: $$I_g ≈ 100-200 mA$$ (typical)

## IGBT vs BJT vs MOSFET:

| Aspect | BJT | MOSFET | IGBT |
|--------|-----|--------|------|
| Gate Control | Current | Voltage | Voltage |
| On-Voltage | 0.2-0.5V | 0.5-2V | 1-3V |
| Drive Power | High | Very Low | Very Low |
| Switching Speed | Medium | Very Fast | Fast |
| Parallel Safe | No | Marginal | Yes |
| Frequency | <100 kHz | 1-100 MHz | 1-50 kHz |
| Power Rating | High | Medium-High | Very High |
| Cost | Low | Medium | Medium-High |

## Applications:

- **Motor drives** (variable frequency drives)
- **Welding equipment**
- **Power supplies** (high power SMPS)
- **UPS systems**
- **Solar inverters**
- **Wind turbine converters**
- **Traction drives** (locomotives, electric vehicles)',
'Modern Devices', 'IGBTs', 'Transistors', 2, 41, 'hard');

COMMIT;
