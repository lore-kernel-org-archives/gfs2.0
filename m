Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC035506
	for <gfs2@lists.linux.dev>; Wed, 11 Oct 2023 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bayeAah0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6664EC433C7;
	Wed, 11 Oct 2023 06:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697005518;
	bh=fbABpt57oyvBzr7MqQakhuu6vprh4A4yq0O9urYFSyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bayeAah0No+7A9o7C0L3GgS29P5L8pfaO+6qSnwjS9ZC5FW5YV0u9QSCdy/CrC9tA
	 Xf2UBCsK+kB2HExnSB/NZ39nIQHJ1Yda+JLKM23hVO9tPOMikLl2L1CXi5rP9Cr9Iz
	 jNljQ4OMzZ+q4/8kv644vOPcnWWA7AhxdukpvgkM=
Date: Wed, 11 Oct 2023 08:25:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, cluster-devel@redhat.com, gfs2@lists.linux.dev,
	christophe.jaillet@wanadoo.fr, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 4/8] dlm: fix creating multiple node structures
Message-ID: <2023101138-rickety-collector-e9fc@gregkh>
References: <20231010220448.2978176-1-aahringo@redhat.com>
 <20231010220448.2978176-4-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010220448.2978176-4-aahringo@redhat.com>

On Tue, Oct 10, 2023 at 06:04:44PM -0400, Alexander Aring wrote:
> This patch will lookup existing nodes instead of always creating them
> when dlm_midcomms_addr() is called. The idea is here to create midcomms
> nodes when user space getting informed that nodes joins the cluster. This
> is the case when dlm_midcomms_addr() is called, however it can be called
> multiple times by user space to add several address configurations to one
> node e.g. when using SCTP. Those multiple times need to be filtered out
> and we doing that by looking up if the node exists before. Due configfs
> entry it is safe that this function gets only called once at a time.
> 
> Cc: stable@vger.kernel.org
> Fixes: 63e711b08160 ("fs: dlm: create midcomms nodes when configure")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/midcomms.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Why does patch 4/8 have a cc: stable, when it depends on patches 1-3 as
well?  That is going to drive us crazy when it hits Linus's tree, how do
we know the dependancies here anymore?

thanks,

greg k-h
