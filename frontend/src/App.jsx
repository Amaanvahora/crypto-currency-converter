import "./App.css";
import CurrencySelector from "./components/CurrencySelector";
import contractABI from "./contracts/currency.json";

// Replace with your contract address
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

function App() {
  return (
    <div className="App" style={{ background: 'white' }}>
      <header className="App-header">
        <h1>Amaan's Crypto Currency Converter </h1>
        <CurrencySelector
          contractAddress={contractAddress}
          contractABI={contractABI}
        />
      </header>
    </div>
  );
}

export default App;
