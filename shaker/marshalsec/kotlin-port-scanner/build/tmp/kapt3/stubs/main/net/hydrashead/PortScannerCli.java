package net.hydrashead;

import java.lang.System;

@kotlin.Metadata(mv = {1, 6, 0}, k = 1, d1 = {"\u00006\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\b\n\u0002\b\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u000e\n\u0002\b\u0005\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\b\n\u0002\u0018\u0002\n\u0002\b\u0004\b\u0007\u0018\u00002\b\u0012\u0004\u0012\u00020\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0003J\r\u0010\n\u001a\u00020\u0002H\u0016\u00a2\u0006\u0002\u0010\u000bJ$\u0010\f\u001a\b\u0012\u0004\u0012\u00020\u000e0\r2\u0006\u0010\u0006\u001a\u00020\u000f2\f\u0010\u0010\u001a\b\u0012\u0004\u0012\u00020\u00020\rH\u0002J\u0016\u0010\u0011\u001a\b\u0012\u0004\u0012\u00020\u000f0\r2\u0006\u0010\u0012\u001a\u00020\u0007H\u0002J\u0016\u0010\u0013\u001a\b\u0012\u0004\u0012\u00020\u000f0\r2\u0006\u0010\u0012\u001a\u00020\u0007H\u0002J\u0016\u0010\u0014\u001a\b\u0012\u0004\u0012\u00020\u00020\r2\u0006\u0010\b\u001a\u00020\u0007H\u0002J\u0016\u0010\u0015\u001a\b\u0012\u0004\u0012\u00020\u00020\r2\u0006\u0010\u0016\u001a\u00020\u0007H\u0002J-\u0010\u0017\u001a\u000e\u0012\u0004\u0012\u00020\u0007\u0012\u0004\u0012\u00020\u00050\u00182\u0006\u0010\u0019\u001a\u00020\u000e2\u0006\u0010\t\u001a\u00020\u0002H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u001aJ\f\u0010\u001b\u001a\u00020\u0005*\u00020\u0007H\u0002R\u0012\u0010\u0004\u001a\u00020\u00058\u0002@\u0002X\u0083\u000e\u00a2\u0006\u0002\n\u0000R\u0012\u0010\u0006\u001a\u00020\u00078\u0002@\u0002X\u0083.\u00a2\u0006\u0002\n\u0000R\u0012\u0010\b\u001a\u00020\u00078\u0002@\u0002X\u0083\u000e\u00a2\u0006\u0002\n\u0000R\u0012\u0010\t\u001a\u00020\u00028\u0002@\u0002X\u0083\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\b\u0019\u00a8\u0006\u001c"}, d2 = {"Lnet/hydrashead/PortScannerCli;", "Ljava/util/concurrent/Callable;", "", "()V", "force", "", "host", "", "portArg", "timeout", "call", "()Ljava/lang/Integer;", "generateAddresses", "", "Ljava/net/InetSocketAddress;", "Ljava/net/InetAddress;", "ports", "getListFromCIDR", "hostArg", "parseHostsArg", "parsePortArg", "parsePortRangeArg", "portRange", "scan", "Lkotlin/Pair;", "address", "(Ljava/net/InetSocketAddress;ILkotlin/coroutines/Continuation;)Ljava/lang/Object;", "isCIDR", "kotlin-port-scanner"})
@picocli.CommandLine.Command(name = "kotlin-port-scanner", version = {"0.1"}, mixinStandardHelpOptions = true, description = {"A simple port scanner written in Kotlin"})
public final class PortScannerCli implements java.util.concurrent.Callable<java.lang.Integer> {
    @picocli.CommandLine.Parameters(index = "0", arity = "1", description = {"Host to scan, use IP, CIDR or DNS"})
    private java.lang.String host;
    @picocli.CommandLine.Option(names = {"-p", "--ports"}, defaultValue = "-", description = {"Ports to scan. Separate by commas, use - to specify ranges. Eg: 80,443,8000-9000", "Will scan all ports by default"})
    private java.lang.String portArg = "-";
    @picocli.CommandLine.Option(names = {"-f", "--force"}, defaultValue = "false", description = {"Force the scan regardless of ping status. Server ping may require root privileges."})
    private boolean force = false;
    @picocli.CommandLine.Option(names = {"-t", "--timeout"}, defaultValue = "1000", description = {"Timeout in ms. Default is 1000"})
    private int timeout = 1000;
    
    public PortScannerCli() {
        super();
    }
    
    @org.jetbrains.annotations.NotNull()
    @java.lang.Override()
    public java.lang.Integer call() {
        return null;
    }
    
    private final java.lang.Object scan(java.net.InetSocketAddress address, int timeout, kotlin.coroutines.Continuation<? super kotlin.Pair<java.lang.String, java.lang.Boolean>> continuation) {
        return null;
    }
    
    private final java.util.List<java.net.InetSocketAddress> generateAddresses(java.net.InetAddress host, java.util.List<java.lang.Integer> ports) {
        return null;
    }
    
    private final java.util.List<java.net.InetAddress> parseHostsArg(java.lang.String hostArg) {
        return null;
    }
    
    private final java.util.List<java.net.InetAddress> getListFromCIDR(java.lang.String hostArg) {
        return null;
    }
    
    private final java.util.List<java.lang.Integer> parsePortArg(java.lang.String portArg) {
        return null;
    }
    
    private final java.util.List<java.lang.Integer> parsePortRangeArg(java.lang.String portRange) {
        return null;
    }
    
    private final boolean isCIDR(java.lang.String $this$isCIDR) {
        return false;
    }
}