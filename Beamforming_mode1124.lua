-- Radar Settings (Original)
-- 3 Tx 4 Rx | complex 1x


COM_PORT = 6 -- 12 for 1843 on Edwin laptop (Application Port)
RADARSS_PATH = "C:\\ti\\mmwave_studio_02_01_01_00\\rf_eval_firmware\\radarss\\xwr68xx_radarss.bin"
MASTERSS_PATH = "C:\\ti\\mmwave_studio_02_01_01_00\\rf_eval_firmware\\masterss\\xwr68xx_masterss.bin"
-- SAVE_DATA_PATH = "C:\\ti\\mmwave_studio_02_01_01_00\\mmWaveStudio\\Data\\adc_data.bin"
-- SAVE_DATA_PATH = "D:\\data\\adc_data.bin"
-- DUMP_DATA_PATH = "C:\\ti\\mmwave_studio_02_01_01_00\\mmWaveStudio\\Data\\adc_data_RAW_0.bin"
-- PKT_LOG_PATH  = "C:\\ti\\mmwave_studio_02_01_01_00\\mmWaveStudio\\Data\\pktlogfile.txt"
SAVE_DATA_PATH = "D:\\data\\adc_data.bin"
DUMP_DATA_PATH = "D:\\data\\adc_data_RAW_0.bin"
PKT_LOG_PATH  = "D:\\data\\pktlogfile.txt"
--------------------------------------------

-------- VERY IMPORTANT AND SERIOUS RADAR SETTINGS --------
-- General
NUM_TX = 3 --3
NUM_RX = 4

-- ProfileConfig
START_FREQ = 60 -- GHz -- this is not valid
IDLE_TIME = 10 -- us
RAMP_END_TIME = 200 -- us
ADC_START_TIME = 6 --us
FREQ_SLOPE = 1.81 -- MHz/us 54.701
ADC_SAMPLES = 128 --=SAMPLE PER CHIRP
SAMPLE_RATE = 2000-- ksps
RX_GAIN = 30 -- dB



-- ChirpConfig
-- yeah...I didn't parameterize this one since I didn't think we would change anything here
-- the setup is such that we receive Rx information in the order of Tx1->Tx3->Tx2
-- this translates to getting all the azimuth information first (indices [0,7]) then getting any elevation information (indices [8,11])

-- FrameConfig
START_CHIRP_TX = 0
END_CHIRP_TX = 0 -- 3 -- 2 for 1843
NUM_FRAMES = 0 -- Set this to 0 to continuously stream data
CHIRP_LOOPS = 128--    //128
PERIODICITY = 90-- ms  //30 --75

-- AdvFrameConfig, valid for Tx beamforming mode
NUM_FRAMES = 0 -- Set this to 0 to continuously stream data
Num_SubFrames = 4 -- don't change
Num_Chirps = 3
Num_Loops = 10
Burst_Period = 10
Num_Burst = 1
Num_Burst_Loops = 1
Sub_Frame_Period = 55
-----------------------------------------------------------

-------- THIS IS FINE --------
ar1.FullReset()
ar1.SOPControl(2)
ar1.Connect(COM_PORT,921600,1000)
------------------------------

ar1.Calling_IsConnected()
ar1.SelectChipVersion("AR1642")
ar1.frequencyBandSelection("77G")
ar1.SelectChipVersion("XWR1843")
ar1.SelectChipVersion("AR1642")
ar1.SelectChipVersion("XWR1843")

-------- DOWNLOAD FIRMARE --------
ar1.DownloadBSSFw(RADARSS_PATH)
ar1.GetBSSFwVersion()
ar1.GetBSSPatchFwVersion()
ar1.DownloadMSSFw(MASTERSS_PATH)
ar1.PowerOn(0, 1000, 0, 0)
ar1.RfEnable()
ar1.GetBSSFwVersion()
--------

-------- STATIC CONFIG STUFF --------
ar1.ChanNAdcConfig(1, 1, 1, 1, 1, 1, 1, 2, 1, 0)
-- ar1.ChanNAdcConfig(1, 1, 1, 1, 1, 1, 1, 2, 0, 0)
ar1.LPModConfig(0, 0)
ar1.RfInit()
--------------------------------------

-------- DATA CONFIG STUFF --------
ar1.DataPathConfig(513, 1216644097, 0)
ar1.LvdsClkConfig(1, 1)
ar1.LVDSLaneConfig(0, 1, 1, 0, 0, 1, 0, 0)
-----------------------------------

-------- SENSOR CONFIG STUFF --------
-- ar1.ProfileConfig(0, START_FREQ, IDLE_TIME, ADC_START_TIME, RAMP_END_TIME, 0, 0, 0, 0, 0, 0, FREQ_SLOPE, 0, ADC_SAMPLES, SAMPLE_RATE, 0, 0, RX_GAIN)
--40 degree
--ar1.ProfileConfig(0, 60, 10, 6, 200, 0, 0, 0, 0, 0, 0, 3.114, 0, 128, 2000, 0, 0, 30)
--ar1.ProfileConfig(1, 60, 10, 6, 200, 0, 0, 0, 39.375, 39.375, 39.375, 3.114, 0, 128, 2000, 0, 0, 30)
--ar1.ProfileConfig(2, 60, 10, 6, 200, 0, 0, 0, 78.75, 78.75, 78.75, 3.114, 0, 128, 2000, 0, 0, 30)
--ar1.ProfileConfig(3, 60, 10, 6, 200, 0, 0, 0, 118.125, 118.125, 118.125, 3.114, 0, 128, 2000, 0, 0, 30)

--20 degree
ar1.ProfileConfig(0, 60, 10, 6, 200, 0, 0, 0, 0, 0, 0, 3.114, 0, 128, 2000, 0, 0, 30)
ar1.ProfileConfig(1, 60, 10, 6, 200, 0, 0, 0, 22.5, 22.5, 22.5, 3.114, 0, 128, 2000, 0, 0, 30)
ar1.ProfileConfig(2, 60, 10, 6, 200, 0, 0, 0, 39.375, 39.375, 39.375, 3.114, 0, 128, 2000, 0, 0, 30)
ar1.ProfileConfig(3, 60, 10, 6, 200, 0, 0, 0, 61.875, 61.875, 61.875, 3.114, 0, 128, 2000, 0, 0, 30)


ar1.ChirpConfig(0, 0, 0, 0, 0, 0, 7, 1, 1, 1)
ar1.ChirpConfig(1, 1, 1, 0, 0, 0, 7, 1, 1, 1)
ar1.ChirpConfig(2, 2, 2, 0, 0, 0, 7, 1, 1, 1)
ar1.ChirpConfig(3, 3, 3, 0, 0, 0, 7, 1, 1, 1)
-- test 10 frames
-- ar1.AdvanceFrameConfig(4, 1537, 0, 0, 3, 10, 2000000, 0, 1, 1, 11000000, 1, 0, 3, 10, 2000000, 1,1, 1, 11000000, 2, 0, 3, 10, 2000000, 2, 1, 1, 11000000, 3, 0, 3, 10,2000000, 3, 1, 1, 11000000, 10, 1, 0, 4, 30, 256, 1, 30, 256, 1, 30,256, 1, 30, 256, 1)

ar1.AdvanceFrameConfig(4, 1537, 0, 0, 3, 10, 2000000, 0, 1, 1, 11000000, 1, 0, 3, 10, 2000000, 1,1, 1, 11000000, 2, 0, 3, 10, 2000000, 2, 1, 1, 11000000, 3, 0, 3, 10,2000000, 3, 1, 1, 11000000, 0, 1, 0, 4, 30, 256, 1, 30, 256, 1, 30,256, 1, 30, 256, 1)

-- less loops
-- ar1.AdvanceFrameConfig(4, 1537, 0, 0, 3, 5, 1000000, 0, 1, 1, 6000000, 1, 0, 3, 5, 1000000, 1,1, 1, 6000000, 2, 0, 3, 5, 1000000, 2, 1, 1, 6000000, 3, 0, 3, 5,1000000, 3, 1, 1, 6000000, 0, 1, 0, 4, 15, 256, 1, 15, 256, 1, 15,256, 1, 15, 256, 1)
-------------------------------------




-------- ETHERNET STUFF --------
ar1.SelectCaptureDevice("DCA1000")
ar1.CaptureCardConfig_EthInit("192.168.33.30", "192.168.33.180", "12:34:56:78:90:12", 4096, 4098)
ar1.CaptureCardConfig_Mode(1, 2, 1, 2, 3, 30)
ar1.CaptureCardConfig_PacketDelay(25)
--------------------------------

--ar1.CaptureCardConfig_StartRecord(SAVE_DATA_PATH, 1)
--ar1.StartFrame()

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

-------- CALCULATED AND NOT TOO SERIOUS PARAMETERS --------
CHIRPS_PER_FRAME = (END_CHIRP_TX - START_CHIRP_TX + 1) * CHIRP_LOOPS
NUM_DOPPLER_BINS = CHIRPS_PER_FRAME / NUM_TX
NUM_RANGE_BINS = ADC_SAMPLES
RANGE_RESOLUTION = (3e8 * SAMPLE_RATE * 1e3) / (2 * FREQ_SLOPE * 1e12 * ADC_SAMPLES)
MAX_RANGE = (300 * 0.9 * SAMPLE_RATE) / (2 * FREQ_SLOPE * 1e3)
DOPPLER_RESOLUTION = 3e8 / (2 * START_FREQ * 1e9 * (IDLE_TIME + RAMP_END_TIME) * 1e-6 * NUM_DOPPLER_BINS * NUM_TX)
MAX_DOPPLER = 3e8 / (4 * START_FREQ * 1e9 * (IDLE_TIME + RAMP_END_TIME) * 1e-6 * NUM_TX)

print("\n\nI wanted to make the outputted parameters easy to find so I put them inbetween two memes:")
print("https://www.google.com/search?q=the+nerd+life+chose+me+meme&rlz=1C1CHBF_enUS794US794&source=lnms&tbm=isch&sa=X&ved=0ahUKEwiEg_zw09DjAhVRCM0KHVgfC3cQ_AUIESgB&biw=1536&bih=722#imgrc=EW0Rq0cJqCXu6M:\n")


print("Chirps Per Frame:", CHIRPS_PER_FRAME)
print("Num Doppler Bins:", NUM_DOPPLER_BINS)
print("Num Range Bins:", NUM_RANGE_BINS)
print("Range Resolution:", RANGE_RESOLUTION)
print("Max Unambiguous Range:", MAX_RANGE)
print("Doppler Resolution:", DOPPLER_RESOLUTION)
print("Max Doppler:", MAX_DOPPLER)

print("\nhttps://inteng-storage.s3.amazonaws.com/images/JANUARY/sizes/memes_about_engineers_before_after_resize_md.jpg\n\n")


-- Post Processing will only be done if scan is NOT realtime
-- if NUM_FRAMES ~= 0 then
--     RSTD.Sleep(2000)
--     ar1.PacketReorderZeroFill(DUMP_DATA_PATH, SAVE_DATA_PATH, PKT_LOG_PATH)
-- end
-----------------------------------------------