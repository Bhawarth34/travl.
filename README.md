
# Travl - Your AI-Powered Travel Safety Companion  

### About Travl  
Travl is an AI-powered safety companion designed to ensure secure and worry-free travel for ride-hailing users. The app provides real-time ride monitoring, emergency contact alerts, AI-driven sentiment analysis, and OTP-based safety verification to protect passengers throughout their journey.  

### Key Features  
- **Real-time Ride Monitoring** - Tracks your journey and detects unusual route deviations.  
- **Emergency Contact Activation** - Automatically shares live location with selected contacts.  
- **AI-Powered Audio & Sentiment Analysis** - Uses advanced AI models to detect distress from conversations.  
- **OTP-Based Safety Checks** - Sends an OTP if the car slows down, stops abruptly, or changes its route.  
- **Pre-Ride Safety Checklist** - Ensures passengers check for child locks and verify driver details before starting the ride.  
- **Emergency Mode Activation** - Instantly alerts authorities and records video/audio in case of danger.  

### Worst-Case Scenarios & AI Functionality  
Travl ensures passenger safety in multiple worst-case scenarios using AI-powered features:  

* Route Diversion:
   - If the car deviates significantly from the intended route, Travl detects it using real-time GPS tracking.  
   - An OTP is sent to the user to verify their safety.  
   - If the user acknowledges the OTP, the ride continues as usual.  

* Abrupt Stop: 
   - If the vehicle stops suddenly without a scheduled stop, Travl sends an OTP to the user.  
   - If the user acknowledges the OTP, the ride continues normally.  

* Car Slowing Down Unusually:
   - If the car significantly slows down in an unexpected area, Travl detects this anomaly.  
   - The app sends an OTP to confirm the user's safety.  
   - If the user acknowledges the OTP, the ride continues as expected.  

* User Unresponsive to OTPs:  
   - If a user fails to respond to OTPs in any of the above scenarios, Travl assumes potential danger.  
   - AIxplain’s Speech Recognition model starts recording audio in small 5-second segments.  
   - Once the audio is recorded, the Speech Recognition model converts it into text.  
   - The Sentiment Analysis model then analyzes the tone of the text.  
   - If the response is positive, the ride continues as usual.  
   - If the response is neutral, another round of analysis is performed.  
   - If the response is negative, emergency contacts are alerted immediately with real-time transcripts.  

### AIxplain’s AI Agents in Action  
Travl integrates AIxplain’s  Speech Recognition and  Sentiment Analysis  models to analyze conversations during a ride. If distress is detected, alerts are sent to emergency contacts immediately. These AI models work in real time, ensuring passenger safety without delays.  



#### Tech Stack  
- Frontend: Flutter (Dart)  
- Backend: Node.js (Express.js)  
- Database: Firebase  
- AI Integration: AIxplain Speech Recognition & Sentiment Analysis Models  

#### Installation Guide  
1. Clone the Repository:
   sh
   git clone https://github.com/your-username/travl-app.git
   cd travl-app
     
2. Install Dependencies: 
   sh
   flutter pub get
     
3. Run the App:
   sh
   flutter run
     
4. Backend Setup:  
   - Install Node.js and navigate to the backend folder.  
   sh
   cd backend
   npm install
   npm start


