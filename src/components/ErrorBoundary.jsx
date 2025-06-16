import React from 'react';
import { devError } from '../utils/devLog';

class ErrorBoundary extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            hasError: false,
            error: null,
            errorInfo: null
        };
    }

    static getDerivedStateFromError(error) {
        return { hasError: true, error };
    }

    componentDidCatch(error, errorInfo) {
        this.setState({
            error: error,
            errorInfo: errorInfo
        });

        // Log the error
        devError('Error caught by boundary:', error);
        devError('Error info:', errorInfo);
    }

    render() {
        if (this.state.hasError) {
            return (
                <div style={{
                    padding: '20px',
                    margin: '20px',
                    border: '1px solid #ff4444',
                    borderRadius: '8px',
                    backgroundColor: '#fff5f5',
                    color: '#cc0000',
                    fontFamily: 'system-ui, -apple-system, sans-serif'
                }}>
                    <h2 style={{ margin: '0 0 10px 0' }}>Something went wrong</h2>
                    <p style={{ margin: '0 0 10px 0' }}>
                        {this.state.error?.message || 'An unexpected error occurred'}
                    </p>
                    <button
                        onClick={() => {
                            this.setState({ hasError: false, error: null, errorInfo: null });
                            window.location.reload();
                        }}
                        style={{
                            padding: '8px 16px',
                            backgroundColor: '#cc0000',
                            color: 'white',
                            border: 'none',
                            borderRadius: '4px',
                            cursor: 'pointer'
                        }}
                    >
                        Try Again
                    </button>
                    {process.env.NODE_ENV === 'development' && this.state.errorInfo && (
                        <details style={{ marginTop: '10px' }}>
                            <summary>Error Details</summary>
                            <pre style={{
                                marginTop: '10px',
                                padding: '10px',
                                backgroundColor: '#f8f8f8',
                                borderRadius: '4px',
                                overflow: 'auto'
                            }}>
                                {this.state.errorInfo.componentStack}
                            </pre>
                        </details>
                    )}
                </div>
            );
        }

        return this.props.children;
    }
}

export default ErrorBoundary; 