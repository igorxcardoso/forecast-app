import { useState } from 'react'
import './App.css'

function App() {
  const [zip, setZip] = useState("")
  const [temperature, setTemperature] = useState(null)
  const [error, setError] = useState("")
  const [cached, setCached] = useState(false)
  const [address, setAddress] = useState("")

  const handleFetch = async () => {
    if (!zip) return
    try {
      setError(null)
      setTemperature(null)
      setAddress("")

      const res = await fetch(
        `${import.meta.env.VITE_API_URL}/forecast`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ zip: zip })
      })

      const data = await res.json()

      if (!res.ok) {
        throw new Error(data.message || "An unexpected error occurred. Please try again.")
      }

      setTemperature(data.currentTemperature)
      setCached(data.cached)
      setAddress(data.address || zip)
      setZip("")
    } catch (err) {
      setError(err.message)
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
            <div className="result-container">
              <p className="address">📍 {address}</p>
              <p className="result">Current temperature: <strong>{temperature} °C</strong></p>
              {cached && <p className="cached-indicator">💾 Result from cache</p>} {}
            </div>
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
