Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344C168CA
	for <gfs2@lists.linux.dev>; Wed, 11 Oct 2023 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="La3F8Cne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF239C433C8;
	Wed, 11 Oct 2023 06:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697005444;
	bh=fEPjuTq/5LdPMhqJydoRTXlWKJlEVMfLdjKxcfvI2o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=La3F8Cne7HJchBfHsMGiXqkBo+TTL2HRBxwqG6++DJkMfinCEJyIEMWdjykl/9JY0
	 6eDOtEwEsEWYiBH6eSovRo0VD/FiN14fVLJgBTgUkKQnzkFS8uMacYekwnBse7gZH/
	 f7bvtYVtKnqMJsa5I+BjuaOFJqp6EhaVFs7GOxBQ=
Date: Wed, 11 Oct 2023 08:24:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, cluster-devel@redhat.com, gfs2@lists.linux.dev,
	christophe.jaillet@wanadoo.fr, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 1/8] fs: dlm: Simplify buffer size computation in
 dlm_create_debug_file()
Message-ID: <2023101151-culminate-guidance-8823@gregkh>
References: <20231010220448.2978176-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010220448.2978176-1-aahringo@redhat.com>

On Tue, Oct 10, 2023 at 06:04:41PM -0400, Alexander Aring wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Use sizeof(name) instead of the equivalent, but hard coded,
> DLM_LOCKSPACE_LEN + 8.
> 
> This is less verbose and more future proof.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/debug_fs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
