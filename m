Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81E1E98EB
	for <gfs2@lists.linux.dev>; Wed, 30 Apr 2025 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997343; cv=none; b=q7QBxXwbT7UG/LWjaxoL+nctCE5V/T0tzrCYi/3oA00nPv4lIMkfiq2G/OdYnDb0pQRuaGnN5RLzZ1t/aeC532PqUh8JtEZHIjoK+NdkGmWzmbj7irizTyONRYGnpWkLMXyi2dFKgGDABp6n+EzzSFeF/NRJ/ZAyKJlW2srOgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997343; c=relaxed/simple;
	bh=xu/WaquUToyVqIqnMukJGzQFTz2Jbz+n9zzYa+AY7T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6FgButnRFDWFQYJF7apN4zl+cz/CYZ6y31QtZbIPjPEmDfKPJVH98QCong3c+/HdPFLThmdmqSj6l22Ee4Qg2D3NYmsouSscdFde9cFlK815KLIOhV6AIeXbnfeVSsUUSjYOz5BArcC5lWhBO1tLFUxnZ9JJAJjGabxuq0xdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZsqvMxY1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZsqvMxY1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf861f936so12145715e9.3
        for <gfs2@lists.linux.dev>; Wed, 30 Apr 2025 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745997339; x=1746602139; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwVdU+p8Cjribpzzu47+3Y6lNhSogeZ4qJ+N7LzVSdk=;
        b=ZsqvMxY1jo2pXlDEr0CpXuJ4DO1tE8jD25EW3D675YayeRHTpMFaNte7SpCgRBJDEM
         NK1WLcV9a3/uiLCUmTumSKBV6WOOT0qCTsdt09tPukDWTcfRbUjhuLDY/KDe4kuVQWFN
         0XOCtinEU59LpccRo0eTcrg/K56DqI7fTeppFGQ/dhXwXERf4SveUBzf+krr7cyB3Ujq
         94EEUowF7u2CjDPRTCe63WYIab1WZ61Jrs02UmhPfP//t5qPvXwK1XeKM7GPmU9w5E7b
         PkuMrR9szXZ8GaimUXjB/BC+/X2Gx3TzyFtUeafKx63silYajL4yjF5jK+DPWkUpBYD3
         x+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745997339; x=1746602139;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwVdU+p8Cjribpzzu47+3Y6lNhSogeZ4qJ+N7LzVSdk=;
        b=tSoePKj5rtc77Dn03pBaEJ215s6mp1Gcqt5jOBe+wb5rR6RU9m4ROefIMhnjGAkGYp
         kSmTwVD0Hn0+zjb5B7HB9XTc98FvYk6z5aUhGXVnV4tf6qZQrzhvVI17qvwaFaNVPPRl
         oZaW0Mpj9a1Tqbd33AjcYP5VqIQodCoSSSN/nNiBfnYzA813LViQjUm5NZznm737obXJ
         bB/JOPEw7eGmUiOBtVvY5pMRfaSs+L93H60mfe+VLR2C7CS3M51ikpY1WBaS4PMhQ4wX
         6xeRq0s0FWv9S9ZP1FybPvJYA+qULBx58mkEddFzaDcQk8F567gbGbDNHGRfyjBP/rPL
         gxwA==
X-Gm-Message-State: AOJu0YwkfLjuWAUuKHEp/hKFVR05TVfRsdHdK2Z15VMi1Cf+j/U/3FyW
	YzIwzFFtddJnCjSy6P99PXUErB2PaiV1K7eb/YJckM2v44AoeQkzQiHmvS1r9Mt+rCDLPSFg/Ox
	O
X-Gm-Gg: ASbGncsxfr9GMQLq2iufr8Uo7JThs9PEnw25aOIeBuUPNZBTwnt5+6wb+cwJL1rcgF+
	FAVk2y0qX24bhw+LO+PRT4B8aU+NDT+HoFsUk8Twtko/1gKmH+ptnKFoOZSgxu9YbpwBSLlAPlw
	H6XXxN5x9Os3D2YFdMhs/FbQaSBYXet1B4nbCBQWMDKDzsuN/NUQIaaVuLBHiklpgKt5aebDNdm
	LQZJt+JNFrSow1hVsPEdZlKqRaEn7QkCUd8um0nqb/3qEbJ0X66DztlUpAECAAirM4NIci5PPuE
	Zz0WXr/C6d0dnBeYwMA4kK5n5kebbQV3FoD9NOJI+nFz01M=
X-Google-Smtp-Source: AGHT+IFJLPKmcjJzq5v4Koh4usSJI1mmrCUsun4CgArN4gij7ohrwdtxpNHxcvTsIZIEmKsAX9ZorA==
X-Received: by 2002:a05:600c:1d15:b0:43b:c228:1ee0 with SMTP id 5b1f17b1804b1-441b43a0643mr483675e9.7.1745997339508;
        Wed, 30 Apr 2025 00:15:39 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77395sm114785525ad.5.2025.04.30.00.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 00:15:39 -0700 (PDT)
Message-ID: <8bf06a86-deb9-40e2-b672-13b04ea727b4@suse.com>
Date: Wed, 30 Apr 2025 15:15:37 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH dlm/next 2/4] dlm: use SHUT_RDWR for SCTP shutdown
To: Alexander Aring <aahringo@redhat.com>, teigland@redhat.com
Cc: gfs2@lists.linux.dev, glass.su@suse.com, lidong.zhong@suse.com
References: <20250429202913.2908521-1-aahringo@redhat.com>
 <20250429202913.2908521-2-aahringo@redhat.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20250429202913.2908521-2-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/25 04:29, Alexander Aring wrote:
> Currently SCTP shutdown() call gets stuck because there is no incoming
> EOF indicator on its socket. On the peer side the EOF indicator as
> recvmsg() returns 0 will be triggered as mechanism to flush the socket
> queue on the receive side. In SCTP recvmsg() function sctp_recvmsg() we
> can see that only if sk_shutdown has the bit RCV_SHUTDOWN set SCTP will
> recvmsg() will return EOF. The RCV_SHUTDOWN bit will only be set when
> shutdown with SHUT_RD is called. We use now SHUT_RDWR to also get a EOF
> indicator from recvmsg() call on the shutdown() initiator.
> 
> SCTP does not support half closed sockets and the semantic of SHUT_WR is
> different here, it seems that calling SHUT_WR on sctp sockets keeps the
> socket open to have the possibility to do some specific SCTP operations on
> it that we don't do here.
> 
> There exists still a difference in the limitations of TCP vs SCTP in
> case if we are required to have a half closed socket functionality. This
> was tried to archieve with DLM protocol changes in the past and
> hopefully we really don't require half closed socket functionality.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Tested-by: Heming zhao <heming.zhao@suse.com>
Reviewed-by: Heming zhao <heming.zhao@suse.com>

> ---
>   fs/dlm/lowcomms.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 50c42b368c83..e4373bce1bc2 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -160,6 +160,7 @@ struct dlm_proto_ops {
>   	bool try_new_addr;
>   	const char *name;
>   	int proto;
> +	int how;
>   
>   	void (*sockopts)(struct socket *sock);
>   	int (*bind)(struct socket *sock);
> @@ -810,7 +811,7 @@ static void shutdown_connection(struct connection *con, bool and_other)
>   		return;
>   	}
>   
> -	ret = kernel_sock_shutdown(con->sock, SHUT_WR);
> +	ret = kernel_sock_shutdown(con->sock, dlm_proto_ops->how);
>   	up_read(&con->sock_lock);
>   	if (ret) {
>   		log_print("Connection %p failed to shutdown: %d will force close",
> @@ -1858,6 +1859,7 @@ static int dlm_tcp_listen_bind(struct socket *sock)
>   static const struct dlm_proto_ops dlm_tcp_ops = {
>   	.name = "TCP",
>   	.proto = IPPROTO_TCP,
> +	.how = SHUT_WR,
>   	.sockopts = dlm_tcp_sockopts,
>   	.bind = dlm_tcp_bind,
>   	.listen_validate = dlm_tcp_listen_validate,
> @@ -1896,6 +1898,7 @@ static void dlm_sctp_sockopts(struct socket *sock)
>   static const struct dlm_proto_ops dlm_sctp_ops = {
>   	.name = "SCTP",
>   	.proto = IPPROTO_SCTP,
> +	.how = SHUT_RDWR,
>   	.try_new_addr = true,
>   	.sockopts = dlm_sctp_sockopts,
>   	.bind = dlm_sctp_bind,

