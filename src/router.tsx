import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { createRouter } from "@tanstack/react-router";
import { useState } from "react";
import { AuthProvider } from "@/hooks/use-auth";
import { Toaster } from "@/components/ui/sonner";
import { routeTree } from "./routeTree.gen";

const queryClient = new QueryClient();

function InnerApp({ children }: { children: React.ReactNode }) {
  // Hold a single QueryClient + AuthProvider above the router outlet.
  const [qc] = useState(() => queryClient);
  return (
    <QueryClientProvider client={qc}>
      <AuthProvider>
        {children}
        <Toaster richColors theme="dark" />
      </AuthProvider>
    </QueryClientProvider>
  );
}

export const getRouter = () => {
  return createRouter({
    routeTree,
    context: { queryClient },
    scrollRestoration: true,
    defaultPreloadStaleTime: 0,
    Wrap: ({ children }) => <InnerApp>{children}</InnerApp>,
  });
};
