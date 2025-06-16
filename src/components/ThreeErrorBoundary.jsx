import React from 'react';
import { devError } from '../utils/devLog';

class ThreeErrorBoundary extends React.Component {
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
        devError('Three.js Error caught by boundary:', error);
        devError('Error info:', errorInfo);

        // Clean up any Three.js resources if needed
        if (this.props.onError) {
            this.props.onError(error);
        }
    }

    render() {
        if (this.state.hasError) {
            return (
                <div style={{
                    position: 'absolute',
                    top: '50%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)',
                    padding: '20px',
                    border: '1px solid #ff4444',
                    borderRadius: '8px',
                    backgroundColor: 'rgba(255, 245, 245, 0.9)',
                    color: '#cc0000',
                    fontFamily: 'system-ui, -apple-system, sans-serif',
                    zIndex: 1000,
                    textAlign: 'center',
                    backdropFilter: 'blur(5px)'
                }}>
                    <h2 style={{ margin: '0 0 10px 0' }}>3D Scene Error</h2>
                    <p style={{ margin: '0 0 10px 0' }}>
                        {this.state.error?.message || 'An error occurred in the 3D scene'}
                    </p>
                    <button
                        onClick={() => {
                            this.setState({ hasError: false, error: null, errorInfo: null });
                            if (this.props.onRetry) {
                                this.props.onRetry();
                            } else {
                                window.location.reload();
                            }
                        }}
                        style={{
                            padding: '8px 16px',
                            backgroundColor: '#cc0000',
                            color: 'white',
                            border: 'none',
                            borderRadius: '4px',
                            cursor: 'pointer',
                            marginRight: '10px'
                        }}
                    >
                        Retry Scene
                    </button>
                    <button
                        onClick={() => {
                            if (this.props.onFallback) {
                                this.props.onFallback();
                            }
                        }}
                        style={{
                            padding: '8px 16px',
                            backgroundColor: '#666',
                            color: 'white',
                            border: 'none',
                            borderRadius: '4px',
                            cursor: 'pointer'
                        }}
                    >
                        Show Fallback
                    </button>
                    {process.env.NODE_ENV === 'development' && this.state.errorInfo && (
                        <details style={{ marginTop: '10px' }}>
                            <summary>Error Details</summary>
                            <pre style={{
                                marginTop: '10px',
                                padding: '10px',
                                backgroundColor: '#f8f8f8',
                                borderRadius: '4px',
                                overflow: 'auto',
                                maxHeight: '200px'
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

export default ThreeErrorBoundary; 