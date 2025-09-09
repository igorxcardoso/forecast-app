import { useState } from 'react'
import './App.css'

function App() {
  const [zip, setZip] = useState("")
  const [temperature, setTemperature] = useState(null)
  const [error, setError] = useState(null)

  const handleFetch = async () => {
    if (!zip) return
    try {
      setError(null)
      setTemperature(null)
      const res = await fetch(
        `${import.meta.env.VITE_API_URL}/forecast`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ zip: zip })
      })

      if (!res.ok) {
        throw new Error("Invalid or not found ZIP Code")
      }
      const data = await res.json()
      setTemperature(data.currentTemperature)
      setZip("")
    } catch (err) {
      setError('An error occurred during the search, please try again!')
    }
  }

  return (
    <>
      <div className="app-container">
        <div className="card">
          <h1>🌤️ Weather by ZIP Code</h1>
          <div className="input-group">
            <input
              type="text"
              placeholder="ZIP Code"
              value={zip}
              onChange={(e) => setZip(e.target.value)}
            />
            <button onClick={handleFetch}>Search</button>
          </div>

          {temperature !== null && (
            <p className="result">Current temperature: <strong>{temperature} °C</strong></p>
          )}

          {error && (
            <p className="error">{error}</p>
          )}
        </div>
      </div>
    </>
  )
}

export default App
